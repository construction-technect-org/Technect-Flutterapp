import 'dart:convert';

import 'package:construction_technect/app/core/utils/chat_utils.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/controllers/connector_chat_system_controller.dart';
import 'package:construction_technect/app/modules/ChatSystem/partner/ChatData/components/share_location_screen.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/chat_image_viewer.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/create_event_dialog.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/event_card_widget.dart';
import 'package:construction_technect/app/modules/ChatSystem/widgets/audio_message_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorChatSystemView extends StatelessWidget {
  final ConnectorChatSystemController controller = Get.put(
    ConnectorChatSystemController(),
  );

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.attach_file, color: MyColors.primary),
              ),
              title: const Text('Document'),
              subtitle: const Text('Share files'),
              onTap: () {
                Navigator.pop(context);
                controller.sendFile();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, color: MyColors.primary),
              ),
              title: const Text('Gallery'),
              subtitle: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                controller.sendImageFromGallery();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: MyColors.primary),
              ),
              title: const Text('Camera'),
              subtitle: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                controller.sendImageFromCamera();
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.videocam, color: MyColors.primary),
              ),
              title: const Text('Video'),
              subtitle: const Text('Record or choose video'),
              onTap: () {
                Navigator.pop(context);
                _showVideoSourceOptions(context);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: MyColors.primary,
                ),
              ),
              title: const Text('Location'),
              subtitle: const Text('Share your current location'),
              onTap: () async {
                Navigator.pop(context);

                final result = await Get.to(() => const ShareLocationScreen());

                if (result != null) {
                  final LatLng loc = result["location"];
                  final String caption = result["caption"] ?? "";

                  controller.sendLocation(
                    message: caption.isNotEmpty ? caption : "",
                    type: "location",
                    latitude: loc.latitude,
                    longitude: loc.longitude,
                  );
                }
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.event, color: MyColors.primary),
              ),
              title: const Text('Event'),
              subtitle: const Text('Send event invitation'),
              onTap: () {
                Navigator.pop(context);
                Get.dialog(
                  CreateEventDialog(
                    onSend:
                        ({
                          required String title,
                          required String date,
                          required String time,
                          String? description,
                        }) {
                          controller.sendEvent(
                            title: title,
                            date: date,
                            time: time,
                            description: description,
                          );
                        },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.video_library, color: MyColors.primary),
            title: const Text('Select from Gallery'),
            onTap: () {
              Navigator.pop(context);
              controller.sendVideoFromGallery();
            },
          ),
          ListTile(
            leading: const Icon(Icons.videocam, color: MyColors.primary),
            title: const Text('Record Video'),
            onTap: () {
              Navigator.pop(context);
              controller.sendVideoFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          backgroundColor: MyColors.white,
          title: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(controller.image)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.name,
                      style: MyTexts.medium18.copyWith(color: MyColors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Obx(
                      () => Text(
                        controller.isOtherUserTyping.value
                            ? 'Typing...'
                            : controller.userStatusText.value,
                        style: MyTexts.regular12.copyWith(
                          color: controller.isOtherUserTyping.value
                              ? MyColors.primary
                              : (controller.isUserOnline.value
                                    ? Colors.green
                                    : Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final messages = controller.messages;

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.all(12),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final messageIndex = messages.length - 1 - index;
                        final message = messages[messageIndex];
                        final isMine =
                            message.sentBy == controller.currentUser.id;
                        final isRead = message.status == MessageStatus.read;

                        return Align(
                          alignment: isMine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isMine
                                    ? MyColors.primary
                                    : MyColors.veryPaleBlue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (message.type == 'image') ...[
                                    GestureDetector(
                                      onTap: () {
                                        final imageUrl =
                                            (message.mediaUrl?.startsWith(
                                                  'http',
                                                ) ??
                                                false)
                                            ? message.mediaUrl!
                                            : 'http://43.205.117.97${message.mediaUrl ?? ''}';

                                        showDialog(
                                          context: context,
                                          barrierColor: Colors.black,
                                          builder: (context) => ChatImageViewer(
                                            imageUrl: imageUrl,
                                            senderName: isMine
                                                ? 'You'
                                                : controller.name,
                                            timestamp: message.createdAt,
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.65,
                                            maxHeight: 300,
                                            minHeight: 150,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 3 / 4,
                                            child: getImageView(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.65,
                                              height: 300,
                                              fit: BoxFit.cover,
                                              finalUrl:
                                                  (message.mediaUrl?.startsWith(
                                                        'http',
                                                      ) ??
                                                      false)
                                                  ? message.mediaUrl!
                                                  : 'http://43.205.117.97${message.mediaUrl ?? ''}',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (message.message.isNotEmpty &&
                                        message.message.toLowerCase() !=
                                            'photo')
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          message.message,
                                          style: MyTexts.bold14.copyWith(
                                            color: isMine
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                  ] else if (message.type == 'video') ...[
                                    GestureDetector(
                                      onTap: () {
                                        final videoUrl =
                                            (message.mediaUrl?.startsWith(
                                                  'http',
                                                ) ??
                                                false)
                                            ? message.mediaUrl!
                                            : 'http://43.205.117.97${message.mediaUrl ?? ''}';
                                        ChatUtils.openFile(videoUrl);
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child:
                                                ChatUtils.buildVideoThumbnailView(
                                                  message.mediaUrl,
                                                ),
                                          ),
                                          const Icon(
                                            Icons.play_circle_fill,
                                            size: 48,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (message.message.isNotEmpty &&
                                        message.message.toLowerCase() !=
                                            'video' &&
                                        !ChatUtils.isVideoFileName(
                                          message.message,
                                        ))
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          message.message,
                                          style: MyTexts.bold14.copyWith(
                                            color: isMine
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                  ] else if (message.type == 'location') ...[
                                    Builder(
                                      builder: (context) {
                                        final location = jsonDecode(
                                          message.message,
                                        );
                                        final lat =
                                            location['latitude'] as double?;
                                        final lng =
                                            location['longitude'] as double?;
                                        final address =
                                            location['address'] ?? '';

                                        if (lat == null || lng == null) {
                                          return const Text(
                                            'Invalid location data',
                                          );
                                        }

                                        return Column(
                                          crossAxisAlignment: isMine
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                final url =
                                                    "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
                                                if (await canLaunchUrl(
                                                  Uri.parse(url),
                                                )) {
                                                  await launchUrl(
                                                    Uri.parse(url),
                                                    mode: LaunchMode
                                                        .externalApplication,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                height: 180,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey[200],
                                                  border: Border.all(
                                                    color: MyColors.primary
                                                        .withValues(alpha: 0.2),
                                                  ),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: GoogleMap(
                                                  initialCameraPosition:
                                                      CameraPosition(
                                                        target: LatLng(
                                                          lat,
                                                          lng,
                                                        ),
                                                        zoom: 15,
                                                      ),
                                                  markers: {
                                                    Marker(
                                                      markerId: const MarkerId(
                                                        'shared_location',
                                                      ),
                                                      position: LatLng(
                                                        lat,
                                                        lng,
                                                      ),
                                                    ),
                                                  },
                                                  zoomControlsEnabled: false,
                                                  scrollGesturesEnabled: false,
                                                  tiltGesturesEnabled: false,
                                                  rotateGesturesEnabled: false,
                                                  myLocationButtonEnabled:
                                                      false,
                                                  onTap: (_) async {
                                                    final url =
                                                        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
                                                    if (await canLaunchUrl(
                                                      Uri.parse(url),
                                                    )) {
                                                      await launchUrl(
                                                        Uri.parse(url),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                              ),
                                              child: Text(
                                                address,
                                                style: MyTexts.bold14.copyWith(
                                                  color: isMine
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ] else if (message.type == 'file') ...[
                                    GestureDetector(
                                      onTap: () {
                                        final fileUrl =
                                            (message.mediaUrl?.startsWith(
                                                  'http',
                                                ) ??
                                                false)
                                            ? message.mediaUrl!
                                            : 'http://43.205.117.97${message.mediaUrl ?? ''}';
                                        ChatUtils.openFile(fileUrl);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isMine
                                              ? Colors.white.withValues(
                                                  alpha: 0.2,
                                                )
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              ChatUtils.getFileIcon(
                                                message.mediaUrl
                                                        ?.split('/')
                                                        .last ??
                                                    message.message,
                                              ),
                                              size: 40,
                                              color: isMine
                                                  ? Colors.white
                                                  : MyColors.primary,
                                            ),
                                            const SizedBox(width: 12),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ChatUtils.extractFileName(
                                                      message.mediaUrl ?? '',
                                                    ),
                                                    style: MyTexts.bold14
                                                        .copyWith(
                                                          color: isMine
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Tap to open',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: isMine
                                                          ? Colors.white70
                                                          : Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (message.message.isNotEmpty &&
                                        !ChatUtils.isFileNameOnly(
                                          message.message,
                                        ))
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          message.message,
                                          style: MyTexts.bold14.copyWith(
                                            color: isMine
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                  ] else if (message.type == 'audio') ...[
                                    AudioMessageWidget(
                                      audioUrl: message.mediaUrl ?? '',
                                      duration: message.message,
                                      isMine: isMine,
                                    ),
                                  ] else if (message.type == 'event') ...[
                                    Obx(
                                      () => EventCardWidget(
                                        messageId: message.id,
                                        eventData: message.message,
                                        isMine: isMine,
                                        isResponding:
                                            controller
                                                .respondingEventId
                                                .value ==
                                            int.tryParse(message.id),
                                        onRespond: (response) {
                                          controller.respondToEvent(
                                            messageId:
                                                int.tryParse(message.id) ?? 0,
                                            response: response,
                                          );
                                        },
                                      ),
                                    ),
                                  ] else
                                    Text(
                                      message.message,
                                      style: MyTexts.bold16.copyWith(
                                        color: isMine
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        ChatUtils.formatTime(message.createdAt),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isMine
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                      if (isMine) ...[
                                        const SizedBox(width: 4),
                                        Icon(
                                          isRead ? Icons.done_all : Icons.check,
                                          size: 14,
                                          color: isRead
                                              ? Colors.blue
                                              : Colors.white70,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Obx(() {
                        if (!controller.showScrollToBottom.value) {
                          return const SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: controller.scrollToBottom,
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.arrow_downward_rounded,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              Container(
                color: MyColors.metricBackground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add, color: MyColors.primary),
                        onPressed: () => _showAttachmentOptions(context),
                      ),
                      Expanded(
                        child: Obx(() {
                          final isRecording = controller.isRecording.value;
                          if (isRecording) {
                            // Show recording indicator like WhatsApp with swipe to cancel
                            return GestureDetector(
                              onHorizontalDragStart: (_) {
                                controller.recordingDragOffset.value = 0.0;
                              },
                              onHorizontalDragUpdate: (details) {
                                // Accumulate horizontal drag for swipe to cancel
                                controller.recordingDragOffset.value +=
                                    details.delta.dx;
                              },
                              onHorizontalDragEnd: (details) {
                                // If swiped left significantly, cancel recording
                                if (details.primaryVelocity != null &&
                                    details.primaryVelocity! < -500) {
                                  controller.stopRecording(send: false);
                                }
                                controller.recordingDragOffset.value = 0.0;
                              },
                              child: Transform.translate(
                                offset: Offset(
                                  controller.recordingDragOffset.value.clamp(
                                    -100.0,
                                    0.0,
                                  ),
                                  0,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Obx(() {
                                        final duration =
                                            controller.recordingDuration.value;
                                        final minutes = duration.inMinutes;
                                        final seconds = duration.inSeconds % 60;
                                        return Text(
                                          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }),
                                      const Spacer(),
                                      Obx(() {
                                        final shouldShowCancel =
                                            controller
                                                .recordingDragOffset
                                                .value <
                                            -50;
                                        return Text(
                                          shouldShowCancel
                                              ? 'Release to cancel'
                                              : 'Slide to cancel',
                                          style: TextStyle(
                                            color: shouldShowCancel
                                                ? Colors.red
                                                : Colors.grey,
                                            fontSize: 14,
                                            fontWeight: shouldShowCancel
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return CommonTextField(
                            controller: controller.messageController,
                            hintText: "Type your message...",
                            onChange: (text) =>
                                controller.onTextChanged(text ?? ''),
                          );
                        }),
                      ),
                      Obx(() {
                        final hasText = controller.hasText.value;
                        final isRecording = controller.isRecording.value;

                        if (hasText) {
                          // Show send button when text is entered
                          return IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: MyColors.primary,
                            ),
                            onPressed: () {
                              final text = controller.messageController.text
                                  .trim();
                              if (text.isNotEmpty) {
                                controller.onSendTap(text);
                                controller.messageController.clear();
                              }
                            },
                          );
                        }

                        // Show microphone button for recording (WhatsApp style)
                        return GestureDetector(
                          onLongPressStart: (_) => controller.startRecording(),
                          onLongPressEnd: (_) =>
                              controller.stopRecording(send: true),
                          onLongPressCancel: () =>
                              controller.stopRecording(send: false),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isRecording
                                  ? Colors.red
                                  : MyColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isRecording ? Icons.mic : Icons.mic,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
