import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/audio_manager.dart';
import 'package:construction_technect/app/core/utils/chat_utils.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/model/connector_chat_model.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/service/connector_chat_service.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/media_preview_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:video_compress/video_compress.dart';

class ConnectorChatSystemController extends GetxController {
  Rx<ChatListModel> chatListModel = ChatListModel().obs;
  RxBool isLoading = false.obs;
  final TextEditingController messageController = TextEditingController();

  late CustomUser currentUser;
  late CustomUser supportUser;

  final RxList<CustomMessage> messages = <CustomMessage>[].obs;
  final ScrollController scrollController = ScrollController();

  final ImagePicker picker = ImagePicker();
  late final IO.Socket socket;
  int groupId = 0;
  String name = "User";
  String number = "";
  String image = "";
  int? otherUserId;
  bool? isVrm;
  VoidCallback? onRefresh;

  // Online status tracking
  RxBool isUserOnline = false.obs;
  Rx<DateTime?> lastSeenTime = Rx<DateTime?>(null);
  RxString userStatusText = 'Offline'.obs;

  // Typing indicator
  RxBool isOtherUserTyping = false.obs;
  Timer? _typingTimer;
  bool _isTyping = false;

  // Scroll helpers
  RxBool showScrollToBottom = false.obs;

  // Event response tracking
  RxInt respondingEventId = 0.obs;

  // Audio recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  RxBool isRecording = false.obs;
  Rx<Duration> recordingDuration = Duration.zero.obs;
  Timer? _recordingTimer;
  String? _currentRecordingPath;
  RxBool hasText = false.obs;
  RxDouble recordingDragOffset = 0.0.obs; // For swipe to cancel

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      final chatData = Get.arguments["chatData"];
      onRefresh = Get.arguments["onRefresh"];
      isVrm = Get.arguments["isVrm"];
      if (chatData != null) {
        groupId = chatData.groupId ?? 0;
        name = chatData.groupName ?? "";
        image =
            APIConstants.bucketUrl +
            (isVrm == true
                ? (chatData.merchantLogo ?? "")
                : (chatData.connectorProfileImage ?? ""));
        // otherUserId = chatData.merchant?.userId;
      }

      currentUser = CustomUser(
        id: myPref.userModel.val["id"].toString(),
        name: name,
        profilePhoto: image,
      );
    }

    supportUser = const CustomUser(id: '', name: '', profilePhoto: '');
    scrollController.addListener(_onScrollChanged);
    messageController.addListener(_onMessageChanged);
    initCalled();
  }

  void _onMessageChanged() {
    hasText.value = messageController.text.trim().isNotEmpty;
  }

  Future<void> initCalled() async {
    await fetchChatList();

    _initSocket();
  }

  /// Update user status text based on online/offline state
  void _updateStatusText() {
    if (isUserOnline.value) {
      userStatusText.value = 'Online';
    } else if (lastSeenTime.value != null) {
      userStatusText.value = 'Last seen ${_formatLastSeen(lastSeenTime.value!)}';
    } else {
      userStatusText.value = 'Offline';
    }
  }

  /// Format last seen time in a user-friendly way
  String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('dd/MM/yyyy').format(lastSeen);
    }
  }

  /// Handle online status updates from socket
  void _handleOnlineStatusUpdate(dynamic data) {
    try {
      if (data == null || data['user_id'] == null) return;

      final userId = data['user_id'];
      final isOnline = data['is_online'] == true;
      final lastSeenStr = data['last_seen'];

      // Only update if this is the user we're chatting with
      if (userId == otherUserId) {
        isUserOnline.value = isOnline;

        if (lastSeenStr != null && !isOnline) {
          lastSeenTime.value = DateTime.parse(lastSeenStr);
        } else {
          lastSeenTime.value = null;
        }

        _updateStatusText();
      }
    } catch (e) {
      log('❌ Error handling online status: $e');
    }
  }

  /// Fetch chat history
  Future<void> fetchChatList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? true;

      final result = await ConnectorChatServices().allChatList(cId: groupId);

      if (result.success == true) {
        chatListModel.value = result;

        final firstMessage = result.chatData?.isNotEmpty == true ? result.chatData!.first : null;

        if (firstMessage != null) {
          final isSenderMe = firstMessage.senderUserId == myPref.userModel.val["id"];
          final otherId = isSenderMe ? firstMessage.receiverUserId : firstMessage.senderUserId;

          supportUser = CustomUser(id: otherId?.toString() ?? '', name: name, profilePhoto: image);
        }

        final fetchedMessages =
            result.chatData?.map((msg) {
              final isSentByMe = msg.senderUserId == myPref.userModel.val["id"];
              return CustomMessage(
                id: msg.id.toString(),
                message: msg.messageText ?? '',
                createdAt: DateTime.parse(msg.createdAt ?? DateTime.now().toIso8601String()),
                sentBy: isSentByMe ? currentUser.id : supportUser.id,
                status: msg.isRead == true ? MessageStatus.read : MessageStatus.delivered,
                type: msg.messageType,
                mediaUrl: msg.messageMediaUrl,
              );
            }).toList() ??
            [];

        messages.assignAll(fetchedMessages);
      }
    } catch (e) {
      log('❌ Error fetching chat list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _initSocket() {
    socket = IO.io(
      'https://constructiontechnect.com',
      IO.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .disableAutoConnect()
          .setPath('/socket.io/')
          .setQuery({'token': myPref.getToken()})
          .enableForceNew()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(1000)
          .build(),
    );

    socket.onConnect((_) {
      log('✅ Connected to socket server - ID: ${socket.id}');
      socket.emit('join_group', {"group_id": groupId});
    });

    socket.onConnectError((data) {
      log('❌ Socket Connect Error: $data');
    });

    socket.onDisconnect((reason) {
      log('🔌 Socket Disconnected: $reason');
    });

    socket.on('joined_group', (data) {
      if (kDebugMode) log('🟢 Joined Group: $data');
      socket.emit('mark_messages_read', {"group_id": groupId});
      //   // Check online status after joining
      //   if (otherUserId != null) {
      //     socket.emit('check_user_online', {'user_id': otherUserId});
      //   }
    });
    // socket.on('new_message', (data) => {if (kDebugMode) log('🟢 New msg: $data')});
    // socket.on('messages_marked_read', (data) {
    //   if (kDebugMode) log('🟢 messages marked as read: $data');
    // });
    //
    // socket.on('messages_read', (data) {
    //   if (kDebugMode) log('🟢 Your messages were read: $data');
    //
    //   _markAllMessagesAsRead();
    // });
    //
    // // Listen for initial online status when joining connection
    // socket.on('user_online_status', (data) {
    //   _handleOnlineStatusUpdate(data);
    // });
    //
    // // Listen for real-time status changes
    // socket.on('user_status_changed', (data) {
    //   _handleOnlineStatusUpdate(data);
    // });
    //
    // // Listen for typing indicators
    // socket.on('user_typing', (data) {
    //   if (data != null && data['user_id'] == otherUserId) {
    //     isOtherUserTyping.value = true;
    //   }
    // });
    //
    // socket.on('user_stopped_typing', (data) {
    //   if (data != null && data['user_id'] == otherUserId) {
    //     isOtherUserTyping.value = false;
    //   }
    // });
    //
    // socket.on('typing_error', (error) {
    //   log('❌ Typing indicator error: ${error['message']}');
    // });
    //
    // // Listen for event updates
    // socket.on('event_updated', (data) {
    //   log('📅 Event updated: $data');
    //   if (data != null && data['success'] == true && data['data'] != null) {
    //     try {
    //       final chatData = ChatData.fromJson(data['data']);
    //       final updatedMessageId = chatData.id.toString();
    //
    //       // Find and update the message in the list
    //       final messageIndex = messages.indexWhere((msg) => msg.id == updatedMessageId);
    //       if (messageIndex != -1) {
    //         final existingMessage = messages[messageIndex];
    //         final updatedMessage = existingMessage.copyWith(
    //           message: chatData.messageText ?? existingMessage.message,
    //         );
    //         messages[messageIndex] = updatedMessage;
    //       }
    //
    //       // Clear responding state
    //       if (respondingEventId.value == chatData.id) {
    //         respondingEventId.value = 0;
    //       }
    //     } catch (e) {
    //       log('❌ Error parsing event update: $e');
    //     }
    //   }
    // });
    //
    // socket.on('event_response_ack', (data) {
    //   log('✅ Event response ack: $data');
    //   respondingEventId.value = 0;
    // });
    //
    // socket.on('event_response_error', (error) {
    //   log('❌ Event response error: $error');
    //   Get.snackbar(
    //     'Error',
    //     error['message'] ?? 'Failed to update event status',
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    //   respondingEventId.value = 0;
    // });
    //
    socket.on('new_message', (data) {
      log("📩 New Message Received: $data");
      try {
        if (data == null || data['data'] == null) return;

        final chatData = ChatData.fromJson(data['data']);
        final isSentByMe = chatData.senderUserId == myPref.userModel.val["id"];

        final newMessage = CustomMessage(
          id: chatData.id.toString(),
          message: chatData.messageText ?? '',
          createdAt: DateTime.parse(chatData.createdAt ?? DateTime.now().toIso8601String()),
          sentBy: isSentByMe ? currentUser.id : supportUser.id,
          status: chatData.isRead == true ? MessageStatus.read : MessageStatus.delivered,
          type: chatData.messageType,
          mediaUrl: chatData.messageMediaUrl,
        );

        messages.add(newMessage);
        _scrollToBottom();
        // socket.emit('mark_messages_read', {"group_id": groupId});
      } catch (e, st) {
        log('❌ Error parsing new message: $e');
        log(st.toString());
      }
    });

    socket.connect();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      showScrollToBottom.value = false;
    }
  }

  void _markAllMessagesAsRead() {
    final updatedMessages = messages.map((msg) {
      if (msg.sentBy == currentUser.id && msg.status != MessageStatus.read) {
        return msg.copyWith(status: MessageStatus.read);
      }
      return msg;
    }).toList();

    messages.assignAll(updatedMessages);
    if (kDebugMode) {
      log(
        '✅ Marked ${updatedMessages.where((m) => m.status == MessageStatus.read && m.sentBy == currentUser.id).length} messages as read',
      );
    }
  }

  void onSendTap(String message) {
    if (message.trim().isEmpty) return;

    // Stop typing indicator when sending message
    _stopTyping();

    socket.emit('send_message', {'group_id': groupId, 'message': message});

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  /// Handle text field changes to emit typing indicator
  void onTextChanged(String text) {
    if (text.trim().isEmpty) {
      _stopTyping();
      return;
    }

    // Emit typing event if not already typing
    if (!_isTyping) {
      _isTyping = true;
      socket.emit('user_typing', {'group_id': groupId});
    }

    // Cancel existing timer
    _typingTimer?.cancel();

    // Auto-stop typing after 2 seconds of inactivity
    _typingTimer = Timer(const Duration(seconds: 2), () {
      _stopTyping();
    });
  }

  /// Stop typing indicator
  void _stopTyping() {
    if (_isTyping) {
      _isTyping = false;
      _typingTimer?.cancel();
      socket.emit('user_stopped_typing', {'group_id': groupId});
    }
  }

  Future<void> sendVideoFromGallery() async {
    try {
      final XFile? pickedFile = await picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );

      if (pickedFile == null) return;

      final filePath = pickedFile.path;
      final fileName = filePath.split('/').last;
      log("🎞️ Video selected from gallery: $filePath");

      // Check original file size before showing preview
      final originalFile = File(filePath);
      final originalSizeInMB = (await originalFile.length()) / (1024 * 1024);

      if (originalSizeInMB > 50) {
        Get.snackbar(
          'Video Too Large',
          'Video is ${originalSizeInMB.toStringAsFixed(1)}MB. Please select a video shorter than 2 minutes.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }

      Get.dialog(
        MediaPreviewDialog(
          videoPath: filePath,
          onSend: (caption) async {
            try {
              // Show compressing dialog
              Get.dialog(
                WillPopScope(
                  onWillPop: () async => false,
                  child: const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Compressing video...'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                barrierDismissible: false,
              );

              _scrollToBottom();

              // Compress video
              final info = await VideoCompress.compressVideo(
                filePath,
                quality: VideoQuality.MediumQuality,
                deleteOrigin: false,
              );

              if (info == null) {
                Get.back(); // Close loading dialog
                Get.snackbar(
                  'Error',
                  'Failed to compress video',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final compressedFile = info.file;
              if (compressedFile == null) {
                Get.back(); // Close loading dialog
                Get.snackbar(
                  'Error',
                  'Failed to compress video',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final bytes = await compressedFile.readAsBytes();
              final fileSizeInMB = bytes.length / (1024 * 1024);

              log("📊 Original size: ${(await File(filePath).length()) / (1024 * 1024)} MB");
              log("📊 Compressed size: $fileSizeInMB MB");

              // Check if file is still too large (max 10MB)
              if (fileSizeInMB > 10) {
                Get.back(); // Close loading dialog
                Get.snackbar(
                  'Error',
                  'Video is too large (${fileSizeInMB.toStringAsFixed(1)}MB). Please select a shorter video.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 4),
                );
                return;
              }

              final base64Video = base64Encode(bytes);

              // Determine mime type from file extension
              final extension = fileName.split('.').last.toLowerCase();
              String mimeType = 'video/mp4';
              switch (extension) {
                case 'mp4':
                  mimeType = 'video/mp4';
                case 'mov':
                  mimeType = 'video/quicktime';
                case 'avi':
                  mimeType = 'video/x-msvideo';
                case 'mkv':
                  mimeType = 'video/x-matroska';
                case '3gp':
                  mimeType = 'video/3gpp';
              }

              Get.back(); // Close loading dialog

              socket.emit('send_message', {
                'group_id': groupId,
                'message_type': 'video',
                'media_base64': base64Video,
                'media_mime_type': mimeType,
                'file_name': fileName,
                'caption': caption.isEmpty ? null : caption,
              });

              log("📤 Sent video from gallery via socket with caption: $caption");
            } catch (e) {
              if (Get.isDialogOpen ?? false) {
                Get.back(); // Close loading dialog
              }
              log("❌ Error compressing/sending video: $e");
              Get.snackbar(
                'Error',
                'Failed to send video: $e',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
        ),
      );
    } catch (e) {
      log("❌ Error selecting/sending video: $e");
      Get.snackbar(
        'Error',
        'Failed to select video: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendVideoFromCamera() async {
    try {
      final XFile? pickedFile = await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 5),
      );

      if (pickedFile == null) return;

      final filePath = pickedFile.path;
      final fileName = filePath.split('/').last;
      log("📹 Video captured from camera: $filePath");

      // Check original file size before showing preview
      final originalFile = File(filePath);
      final originalSizeInMB = (await originalFile.length()) / (1024 * 1024);

      if (originalSizeInMB > 50) {
        Get.snackbar(
          'Video Too Large',
          'Video is ${originalSizeInMB.toStringAsFixed(1)}MB. Please record a shorter video.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }

      Get.dialog(
        MediaPreviewDialog(
          videoPath: filePath,
          onSend: (caption) async {
            try {
              // Show compressing dialog
              Get.dialog(
                WillPopScope(
                  onWillPop: () async => false,
                  child: const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Compressing video...'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                barrierDismissible: false,
              );

              _scrollToBottom();

              // Compress video
              final info = await VideoCompress.compressVideo(
                filePath,
                quality: VideoQuality.MediumQuality,
                deleteOrigin: false,
              );

              if (info == null) {
                Get.back(); // Close loading dialog
                Get.snackbar(
                  'Error',
                  'Failed to compress video',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final compressedFile = info.file;
              if (compressedFile == null) {
                Get.back(); // Close loading dialog
                Get.snackbar(
                  'Error',
                  'Failed to compress video',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final bytes = await compressedFile.readAsBytes();
              final fileSizeInMB = bytes.length / (1024 * 1024);

              log("📊 Original size: ${(await File(filePath).length()) / (1024 * 1024)} MB");
              log("📊 Compressed size: $fileSizeInMB MB");

              // Check if file is still too large (max 10MB)
              if (fileSizeInMB > 10) {
                Get.back(); // Close loading dialog
                Get.snackbar(
                  'Error',
                  'Video is too large (${fileSizeInMB.toStringAsFixed(1)}MB). Please select a shorter video.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 4),
                );
                return;
              }

              final base64Video = base64Encode(bytes);

              // Determine mime type from file extension
              final extension = fileName.split('.').last.toLowerCase();
              String mimeType = 'video/mp4';
              switch (extension) {
                case 'mp4':
                  mimeType = 'video/mp4';
                case 'mov':
                  mimeType = 'video/quicktime';
                case 'avi':
                  mimeType = 'video/x-msvideo';
                case 'mkv':
                  mimeType = 'video/x-matroska';
                case '3gp':
                  mimeType = 'video/3gpp';
              }

              Get.back(); // Close loading dialog

              socket.emit('send_message', {
                'group_id': groupId,
                'message_type': 'video',
                'media_base64': base64Video,
                'media_mime_type': mimeType,
                'file_name': fileName,
                'caption': caption.isEmpty ? null : caption,
              });

              log("📤 Sent video from camera via socket with caption: $caption");
            } catch (e) {
              if (Get.isDialogOpen ?? false) {
                Get.back(); // Close loading dialog
              }
              log("❌ Error compressing/sending video: $e");
              Get.snackbar(
                'Error',
                'Failed to send video: $e',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
        ),
      );
    } catch (e) {
      log("❌ Error capturing/sending video: $e");
      Get.snackbar(
        'Error',
        'Failed to capture video: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendImageFromGallery() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (pickedFile == null) return;

      final filePath = pickedFile.path;
      log("🖼️ Image selected from gallery: $filePath");

      // Show preview dialog with caption option
      Get.dialog(
        MediaPreviewDialog(
          imagePath: filePath,
          onSend: (caption) async {
            _scrollToBottom();
            final bytes = await pickedFile.readAsBytes();
            final base64Image = base64Encode(bytes);

            socket.emit('send_message', {
              'group_id': groupId,
              "message_type": "image",
              'message': caption.isEmpty ? "Photo" : caption,
              "media_base64": base64Image,
              'media_url': filePath,
            });
            log("📤 Sent image message via socket with caption: $caption");
          },
        ),
      );
    } catch (e) {
      log("❌ Error selecting/sending image: $e");
    }
  }

  Future<void> sendImageFromCamera() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (pickedFile == null) return;

      final filePath = pickedFile.path;
      log("📸 Image captured from camera: $filePath");

      // Show preview dialog with caption option
      Get.dialog(
        MediaPreviewDialog(
          imagePath: filePath,
          onSend: (caption) async {
            _scrollToBottom();
            final bytes = await pickedFile.readAsBytes();
            final base64Image = base64Encode(bytes);

            socket.emit('send_message', {
              'group_id': groupId,
              "message_type": "image",
              'message': caption.isEmpty ? "Photo" : caption,
              "media_base64": base64Image,
              'media_url': filePath,
            });
            log("📤 Sent image message via socket with caption: $caption");
          },
        ),
      );
    } catch (e) {
      log("❌ Error capturing/sending image: $e");
    }
  }

  Future<void> sendFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt', 'zip'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      final fileName = file.name;
      final fileSize = file.size;
      final filePath = file.path;

      if (filePath == null) {
        log("❌ File path is null");
        return;
      }

      // Get file extension to determine mime type
      final extension = fileName.split('.').last.toLowerCase();
      String mimeType = 'application/octet-stream';

      switch (extension) {
        case 'pdf':
          mimeType = 'application/pdf';
        case 'doc':
          mimeType = 'application/msword';
        case 'docx':
          mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        case 'xls':
          mimeType = 'application/vnd.ms-excel';
        case 'xlsx':
          mimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        case 'txt':
          mimeType = 'text/plain';
        case 'zip':
          mimeType = 'application/zip';
      }

      log("📄 File selected: $fileName (${(fileSize / 1024).toStringAsFixed(2)} KB)");

      // Show preview dialog with caption option
      Get.dialog(
        MediaPreviewDialog(
          fileName: fileName,
          fileIcon: ChatUtils.getFileIcon(fileName),
          filePath: filePath,
          fileSize: fileSize,
          onSend: (caption) async {
            _scrollToBottom();
            final bytes = file.bytes ?? await File(filePath).readAsBytes();
            final base64File = base64Encode(bytes);

            socket.emit('send_message', {
              'group_id': groupId,
              'message_type': 'file',
              'media_base64': base64File,
              'media_mime_type': mimeType,
              'file_name': fileName,
              'message': caption.isEmpty ? fileName : caption,
            });
            log("📤 Sent file message via socket with caption: $caption");
          },
        ),
      );
    } catch (e) {
      log("❌ Error picking/sending file: $e");
    }
  }

  /// Send event invitation
  void sendEvent({
    required String title,
    required String date,
    required String time,
    String? description,
  }) {
    socket.emit('send_message', {
      'group_id': groupId,
      'message_type': 'event',
      'event_title': title,
      'event_description': description ?? '',
      'event_date': date, // YYYY-MM-DD format
      'event_time': time, // HH:MM 24-hour format
    });

    log('📅 Sent event invitation: $title on $date at $time');
  }

  /// Respond to event invitation (accept/reject)
  void respondToEvent({
    required int messageId,
    required String response, // 'accepted' or 'rejected'
  }) {
    if (!socket.connected) {
      Get.snackbar(
        'Error',
        'Not connected to server',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    respondingEventId.value = messageId;

    socket.emit('respond_event', {
      'group_id': groupId,
      'message_id': messageId,
      'response': response,
    });

    log('📅 Responding to event $messageId: $response');
  }

  Future<void> sendLocation({
    required String type,
    String? message,
    double? latitude,
    double? longitude,
  }) async {
    if (type == 'location') {
      String address = message?.trim() ?? '';
      if ((address.isEmpty || address == '') && latitude != null && longitude != null) {
        try {
          final List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
          if (placemarks.isNotEmpty) {
            final p = placemarks.first;
            address = [
              p.name,
              p.subLocality,
              p.locality,
              p.administrativeArea,
              p.country,
            ].where((e) => e != null && e.isNotEmpty).join(', ');
            print(address);
          }
        } catch (e) {
          address = '';
          debugPrint('Reverse geocoding failed: $e');
        }
      }

      final locationData = {"latitude": latitude, "longitude": longitude, "address": address};

      socket.emit('send_message', {
        "group_id": groupId,
        "message_type": 'location',
        "message": jsonEncode(locationData),
      });

      debugPrint("📍 Location sent: $locationData");
    } else {
      socket.emit('send_message', {
        "group_id": groupId,
        "message_type": type,
        "message": message ?? '',
      });
    }
  }

  /// Start audio recording
  Future<void> startRecording() async {
    try {
      // Stop any playing audio before recording
      await AudioManager().stopAll();

      if (await _audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        _currentRecordingPath = '${directory.path}/audio_$timestamp.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
          path: _currentRecordingPath!,
        );

        isRecording.value = true;
        recordingDuration.value = Duration.zero;

        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          recordingDuration.value = Duration(seconds: timer.tick);
        });

        log('🎤 Started recording: $_currentRecordingPath');
      } else {
        Get.snackbar(
          'Permission Denied',
          'Microphone permission is required to record audio',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log('❌ Error starting recording: $e');
      Get.snackbar(
        'Error',
        'Failed to start recording: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Stop audio recording and send or cancel
  Future<void> stopRecording({bool send = true}) async {
    try {
      if (!isRecording.value) return;

      _recordingTimer?.cancel();
      final duration = recordingDuration.value;
      final path = await _audioRecorder.stop();
      isRecording.value = false;

      // Check if recording is at least 1 second
      if (path != null && send && path.isNotEmpty) {
        if (duration.inSeconds < 1) {
          // Recording is less than 1 second, cancel it
          Get.snackbar(
            'Recording too short',
            'Audio must be at least 1 second long',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          try {
            final file = File(path);
            if (await file.exists()) {
              await file.delete();
            }
          } catch (e) {
            log('❌ Error deleting short recording: $e');
          }
        } else {
          // Send the audio file
          await _sendAudioFile(path);
        }
      } else if (path != null && !send) {
        // Delete the recording if cancelled
        try {
          final file = File(path);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (e) {
          log('❌ Error deleting cancelled recording: $e');
        }
      }

      _currentRecordingPath = null;
      recordingDuration.value = Duration.zero;
    } catch (e) {
      log('❌ Error stopping recording: $e');
      isRecording.value = false;
      recordingDuration.value = Duration.zero;
    }
  }

  /// Send audio file via socket
  Future<void> _sendAudioFile(String audioPath) async {
    try {
      final file = File(audioPath);
      if (!await file.exists()) {
        Get.snackbar(
          'Error',
          'Audio file not found',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final bytes = await file.readAsBytes();
      final base64Audio = base64Encode(bytes);
      final fileName = audioPath.split('/').last;
      final duration = recordingDuration.value;

      // Format duration as MM:SS
      final minutes = duration.inMinutes;
      final seconds = duration.inSeconds % 60;
      final durationText =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      socket.emit('send_message', {
        'group_id': groupId,
        'message_type': 'audio',
        'media_base64': base64Audio,
        'media_mime_type': 'audio/m4a',
        'file_name': fileName,
        'message': durationText, // Store duration as message text
      });

      log('🎵 Sent audio message: $fileName (${durationText})');

      // Clean up the temporary file after sending
      try {
        await file.delete();
      } catch (e) {
        log('⚠️ Could not delete temp audio file: $e');
      }

      _scrollToBottom();
    } catch (e) {
      log('❌ Error sending audio: $e');
      Get.snackbar(
        'Error',
        'Failed to send audio: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScrollChanged);
    messageController.removeListener(_onMessageChanged);
    _typingTimer?.cancel();
    _recordingTimer?.cancel();
    _audioRecorder.dispose();
    // Stop all audio playback when screen closes
    AudioManager().stopAll();
    socket.emit('leave_connection', {"group_id": groupId});
    socket.dispose();
    super.onClose();
  }

  void scrollToBottom() => _scrollToBottom();

  void _onScrollChanged() {
    if (!scrollController.hasClients) return;
    final shouldShow = scrollController.offset > 200;
    if (showScrollToBottom.value != shouldShow) {
      showScrollToBottom.value = shouldShow;
    }
  }
}

class CustomUser {
  final String id;
  final String name;
  final String profilePhoto;

  const CustomUser({required this.id, required this.name, required this.profilePhoto});
}

enum MessageStatus { sending, sent, delivered, read }

class CustomMessage {
  final String id;
  final String message;
  final String sentBy;
  final DateTime createdAt;
  final MessageStatus status;
  final String? type;
  final String? mediaUrl;

  CustomMessage({
    required this.id,
    required this.message,
    required this.sentBy,
    required this.createdAt,
    this.status = MessageStatus.sent,
    this.type = 'text',
    this.mediaUrl,
  });

  CustomMessage copyWith({
    String? id,
    String? message,
    String? sentBy,
    DateTime? createdAt,
    MessageStatus? status,
    String? type,
    String? mediaUrl,
  }) {
    return CustomMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      sentBy: sentBy ?? this.sentBy,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }
}
