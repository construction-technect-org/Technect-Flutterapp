import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/model/connectionModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class ConnectionDialogs {
  static void showAcceptConnectionDialog(
    BuildContext context,
    Connection connection,
  ) {
    final TextEditingController messageController = TextEditingController();
    messageController.text = "Welcome! Let's connect";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 120,
                  child: Image.asset(Asset.connectToCrm, fit: BoxFit.contain),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Accept Connection",
                  style: MyTexts.extraBold20.copyWith(color: MyColors.primary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Send a response message to ${connection.connectorName ?? 'the user'}",
                  style: MyTexts.regular16.copyWith(
                    color: MyColors.dopelyColors,
                    fontFamily: MyTexts.SpaceGrotesk,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: "Enter your response message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.lightGray,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.find<ConnectionInboxController>()
                              .acceptConnection(
                                connection.id ?? 0,
                                messageController.text.trim(),
                              );
                        },
                        buttonName: 'Accept',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showRejectConnectionDialog(
    BuildContext context,
    Connection connection,
  ) {
    final TextEditingController messageController = TextEditingController();
    messageController.text = "Not interested at this time";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel_outlined,
                  size: 60,
                  color: MyColors.red,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Reject Connection",
                  style: MyTexts.extraBold20.copyWith(color: MyColors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Send a rejection message to ${connection.connectorName ?? 'the user'}",
                  style: MyTexts.regular16.copyWith(
                    color: MyColors.dopelyColors,
                    fontFamily: MyTexts.SpaceGrotesk,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: "Enter your rejection message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.lightGray,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.find<ConnectionInboxController>()
                              .rejectConnection(
                                connection.id ?? 0,
                                messageController.text.trim(),
                              );
                        },
                        buttonName: 'Reject',
                        borderRadius: 12,
                        height: 45,
                        verticalPadding: 0,
                        color: MyColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSendConnectionDialog(
      BuildContext context,
      Product product, {
        bool? isFromIn = false,
        void Function()? onTap,
      }) {
    final TextEditingController messageController = TextEditingController();
    messageController.text =
    "Hi, I would like to connect with you for business opportunities.";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Connect to CRM!",
                  style: MyTexts.bold18.copyWith(
                    color: MyColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 2.h),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFEF7E8),
                    border: Border.all(color: const Color(0xFFFDEBC8)),
                  ),
                  child: Text(
                    "To proceed with your request, please connect to CRM.",
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 2.h),
                CommonTextField(
                  controller: messageController,
                  hintText: "Enter your message",
                  maxLine: 3,
                ),

                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () => Navigator.of(context).pop(),
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.white,
                        color: MyColors.grayCD,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: onTap,
                        buttonName: 'Connect',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static void showSendServiceConnectionDialog(
      BuildContext context,
      dynamic service, {
        bool? isFromIn = false,
        void Function(String message)? onTap,
      }) {
    final TextEditingController messageController = TextEditingController();
    messageController.text =
    "Hi, I would like to connect with you for business opportunities.";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Connect to CRM!",
                  style: MyTexts.bold18.copyWith(
                    color: MyColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFEF7E8),
                    border: Border.all(color: const Color(0xFFFDEBC8)),
                  ),
                  child: Text(
                    "To proceed with your request, please connect to CRM.",
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  controller: messageController,
                  hintText: "Enter your message",
                  maxLine: 3,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () => Navigator.of(context).pop(),
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.white,
                        color: MyColors.grayCD,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          if (onTap != null) {
                            onTap(messageController.text);
                          }
                          Navigator.of(context).pop();
                        },
                        buttonName: 'Connect',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static void showRemoveConnectionDialog(
    BuildContext context,
    Connection connection,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: getImageView(
                        finalUrl:
                            APIConstants.bucketUrl +
                            (connection.merchantProfileImageUrl ?? ""),
                        height: 36,
                        width: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connection.merchantName ?? "",
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 14,
                              color: MyColors.veryDarkGray,
                            ),
                            const Gap(4),
                            Text(
                              connection.productName ?? "",
                              style: MyTexts.regular13.copyWith(
                                color: MyColors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFEF7E8),
                    border: Border.all(color: const Color(0xFFFDEBC8)),
                  ),
                  child: Text(
                    "Do you really want to disconnect\nfrom this manufacturer?",
                    style: MyTexts.medium14.copyWith(color: MyColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () => Get.back(),
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.white,
                        color: MyColors.grayCD,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Get.back();
                          // Get.find<ConnectionInboxController>()
                          //     .removeConnection(connection.id ?? 0);
                        },
                        buttonName: 'Confirm',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showBlockDialog(BuildContext context, Connection connection) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: getImageView(
                        finalUrl:
                            APIConstants.bucketUrl +
                            (connection.merchantProfileImageUrl ?? ""),
                        height: 36,
                        width: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connection.merchantName ?? "",
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 14,
                              color: MyColors.veryDarkGray,
                            ),
                            const Gap(4),
                            Text(
                              connection.productName ?? "",
                              style: MyTexts.regular13.copyWith(
                                color: MyColors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFCECE9),
                    border: Border.all(color: const Color(0xFFF9D0CB)),
                  ),
                  child: Text(
                    "Do you really want to block this\nHouse owner?",
                    style: MyTexts.medium14.copyWith(color: MyColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () => Get.back(),
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.white,
                        color: MyColors.grayCD,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Get.back();
                          // Get.find<ConnectionInboxController>()
                          //     .removeConnection(connection.id ?? 0);
                        },
                        buttonName: 'Block',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
