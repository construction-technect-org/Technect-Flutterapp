import 'package:chatview/chatview.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/controllers/chat_system_controller.dart';

class ChatSystemView extends StatefulWidget {
  const ChatSystemView({super.key});

  @override
  State<ChatSystemView> createState() => _ChatSystemViewState();
}

class _ChatSystemViewState extends State<ChatSystemView> {
  late ChatSystemController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatSystemController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: ChatView(
        chatController: controller.chatController,
        onSendTap: controller.onSendTap,
        featureActiveConfig: const FeatureActiveConfig(enableScrollToBottomButton: true),
        // scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
        //   backgroundColor: MyColors.primary,
        //   border: Border.all(color: MyColors.primary.withOpacity(0.3)),
        //   icon: const Icon(
        //     Icons.keyboard_arrow_down_rounded,
        //     color: MyColors.primary,
        //     size: 28,
        //   ),
        // ),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: const ChatViewStateConfiguration(),
        typeIndicatorConfig: const TypeIndicatorConfiguration(
          flashingCircleBrightColor: MyColors.primary,
          flashingCircleDarkColor: MyColors.lightBlue,
        ),
        appBar: ChatViewAppBar(
          backGroundColor: MyColors.white,
          chatTitle: "User",
          elevation: 0,
          profilePicture: "",
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 24),
            ),
          ),

          backArrowColor: MyColors.fontBlack,
          chatTitleTextStyle: MyTexts.medium18.copyWith(color: MyColors.primary),
          // userStatus: "Online",
          // userStatusTextStyle: MyTexts.regular14.copyWith(color: MyColors.green),
        ),

        // 🔹 Background config
        chatBackgroundConfig: ChatBackgroundConfiguration(
          backgroundColor: MyColors.white,
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(color: MyColors.black, fontSize: 15),
          ),
        ),
        sendMessageConfig: SendMessageConfiguration(
          replyTitleColor: MyColors.primary,
          voiceRecordingConfiguration: VoiceRecordingConfiguration(
            backgroundColor: MyColors.primary,
            waveStyle: WaveStyle(
              durationLinesColor: Colors.white,
              waveColor: Colors.white,
              showMiddleLine: false,
              backgroundColor: MyColors.primary,
              showDurationLabel: true,
              durationStyle: MyTexts.medium16.copyWith(color: Colors.white),
              showBottom: false,
            ),
          ),
          textFieldConfig: TextFieldConfiguration(
            hintText: "Type your message...",
            hintStyle: MyTexts.medium13.copyWith(color: MyColors.primary.withValues(alpha: 0.5)),
            textStyle: MyTexts.bold16.copyWith(color: MyColors.primary),
            onMessageTyping: (status) {
              debugPrint(status.toString());
            },
          ),
          defaultSendButtonColor: MyColors.black,
          textFieldBackgroundColor: MyColors.metricBackground,
          replyDialogColor: MyColors.white,
          replyMessageColor: MyColors.lightBlue,
          imagePickerIconsConfig: ImagePickerIconsConfiguration(
            cameraIconColor: MyColors.black,
            galleryIconColor: MyColors.black,
          ),
          micIconColor: MyColors.black,
        ),

        chatBubbleConfig: ChatBubbleConfiguration(

          outgoingChatBubbleConfig: ChatBubble(
            color: MyColors.primary,
            textStyle: MyTexts.bold16.copyWith(color: Colors.white),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          inComingChatBubbleConfig: ChatBubble(
            color: MyColors.veryPaleBlue,
            textStyle: MyTexts.bold16.copyWith(color: Colors.black),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
        ),

        // 🔹 Reaction + reply swipe config
        messageConfig: MessageConfiguration(
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: Colors.white,
            borderColor: MyColors.gra54EA,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        repliedMessageConfig: RepliedMessageConfiguration(
          micIconColor: Colors.black,
          repliedImageMessageHeight: 100,
          repliedImageMessageWidth: 100,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          textStyle: MyTexts.medium14.copyWith(color: Colors.black),
          backgroundColor: MyColors.veryPaleBlue.withValues(alpha: 0.3),
        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(
          replyIconColor: MyColors.white,
          replyIconBackgroundColor: MyColors.primary,
        ),
      ),
    );
  }
}
