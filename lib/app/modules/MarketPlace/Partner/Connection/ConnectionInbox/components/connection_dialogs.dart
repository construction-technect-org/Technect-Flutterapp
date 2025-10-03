import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/model/connectionModel.dart';

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
                    fontFamily: MyTexts.Roboto,
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
                Icon(Icons.cancel_outlined, size: 60, color: MyColors.red),
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
                    fontFamily: MyTexts.Roboto,
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
}
