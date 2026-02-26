

import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/model/connectionModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/incoming_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/outgoing_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class ConnectionDialogs {
  static void showAcceptConnectionDialog(BuildContext context, Connection connection) {
    final TextEditingController messageController = TextEditingController();
    messageController.text = "Welcome! Let's connect";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Accept Connection",
                  style: MyTexts.bold18.copyWith(color: MyColors.primary),
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
                    "Send a response message to {connection.connectorName ?? 'the user'}.",
                    style: MyTexts.medium14.copyWith(color: MyColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  controller: messageController,
                  hintText: "Enter your response message",
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
                          Navigator.of(context).pop();
                          // Get.find<ConnectionInboxController>().acceptConnection(
                          //   connection.id ?? 0,
                          //   messageController.text.trim(),
                          // );
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

  static void showRejectConnectionDialog(BuildContext context, Connection connection) {
    final TextEditingController messageController = TextEditingController();
    messageController.text = "Not interested at this time";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Reject Connection",
                  style: MyTexts.bold18.copyWith(color: MyColors.red),
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
                    "Send a rejection message to {connection.connectorName ?? 'the user'}.",
                    style: MyTexts.medium14.copyWith(color: MyColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  controller: messageController,
                  hintText: "Enter your rejection message",
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
                          Navigator.of(context).pop();
                          // Get.find<ConnectionInboxController>().rejectConnection(
                          //   connection.id ?? 0,
                          //   messageController.text.trim(),
                          // );
                        },
                        buttonName: 'Reject',
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

  static void showSendConnectionDialog(
    BuildContext context,
    Product product, {
    bool? isFromIn = false,
    bool? isConnect = true,
    void Function(String note, String date, String raduis)? onTap,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController messageController = TextEditingController();
    final TextEditingController deliveryDateController = TextEditingController();
    final TextEditingController radiusController = TextEditingController();
    //
    // messageController.text =
    // "Hi, I would like to connect with you for business opportunities.";

    final String word = isConnect == true ? "Connect" : "Requirement";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: GestureDetector(
            onTap: hideKeyboard,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$word to CRM!",
                      style: MyTexts.bold18.copyWith(color: MyColors.primary),
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
                        "To proceed with your request, please ${word.toLowerCase()} to to CRM.",
                        style: MyTexts.medium14.copyWith(color: MyColors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 2.h),
                    CommonTextField(
                      controller: deliveryDateController,
                      headerText: "Estimated Delivery Date",
                      hintText: "Select estimate delivery date",
                      suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
                      maxLine: 1,
                      readOnly: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please select delivery date";
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          deliveryDateController.text =
                              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        }
                      },
                    ),

                    SizedBox(height: 1.h),

                    CommonTextField(
                      controller: radiusController,
                      headerText: "Estimated Radius (in km)",
                      hintText: "Enter radius",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter radius";
                        }
                        if (double.tryParse(val) == null) {
                          return "Enter valid radius";
                        }
                        if (int.tryParse(val) == 0) {
                          return "Radius cannot be zero";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 1.h),

                    // MESSAGE FIELD
                    CommonTextField(
                      headerText: "Note",
                      controller: messageController,
                      hintText: "Enter your note",
                      maxLine: 3,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Please enter your note";
                        }
                        return null;
                      },
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
                              if (formKey.currentState!.validate()) {
                                if (onTap != null) {
                                  onTap(
                                    messageController.text,
                                    deliveryDateController.text,
                                    radiusController.text,
                                  );
                                }
                              }
                            },
                            buttonName: word,
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
    bool? isConnect = true,

    void Function(String note, String date, String raduis)? onTap,
  }) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController messageController = TextEditingController();
    final TextEditingController radiusController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    // messageController.text =
    // "Hi, I would like to connect with you for business opportunities.";
    final String word = isConnect == true ? "Connect" : "Requirement";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: GestureDetector(
            onTap: hideKeyboard,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$word to CRM!",
                      style: MyTexts.bold18.copyWith(color: MyColors.primary),
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
                        "To proceed with your request, please ${word.toLowerCase()} to CRM.",
                        style: MyTexts.medium14.copyWith(color: MyColors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    CommonTextField(
                      controller: dateController,
                      headerText: "Estimated Delivery Date",
                      hintText: "Select estimate delivery date",
                      suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
                      maxLine: 1,
                      readOnly: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please select delivery date";
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          dateController.text =
                              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        }
                      },
                    ),

                    SizedBox(height: 1.h),

                    CommonTextField(
                      controller: radiusController,
                      headerText: "Estimated Radius (in km)",
                      hintText: "Enter radius",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter radius";
                        }
                        if (double.tryParse(val) == null) {
                          return "Enter valid radius";
                        }
                        if (int.tryParse(val) == 0) {
                          return "Radius cannot be zero";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 1.h),
                    CommonTextField(
                      headerText: "Note",
                      controller: messageController,
                      hintText: "Enter your note",
                      maxLine: 3,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Please enter your note";
                        }
                        return null;
                      },
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
                              if (formKey.currentState!.validate()) {
                                if (onTap != null) {
                                  onTap(
                                    messageController.text,
                                    dateController.text,
                                    radiusController.text,
                                  );
                                }
                                Navigator.of(context).pop();
                              }
                            },
                            buttonName: word,
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
            ),
          ),
        );
      },
    );
  }

  static void showRemoveConnectionDialog(BuildContext context, IncomingConnection connection,IconData? icons,String? text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: getImageView(
                    //     finalUrl:
                    //         APIConstants.bucketUrl + (connection.merchantProfileImageUrl ?? ""),
                    //     height: 36,
                    //     width: 36,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icons,size: 25,),
                        // Text(
                        //   "${connection.merchantProfile?.businessName}",
                        //   style: MyTexts.medium14.copyWith(color: MyColors.black),
                        //   textAlign: TextAlign.center,
                        // ),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.location_on_rounded,
                        //       size: 14,
                        //       color: MyColors.veryDarkGray,
                        //     ),
                        //     const Gap(4),
                        //     Text(
                        //       "${connection.merchantProfile?.businessName}",
                        //       style: MyTexts.regular13.copyWith(color: MyColors.black),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: MyTexts.medium15.copyWith(
                      color: MyColors.black,
                    ),
                    children: [
                      const TextSpan(text: "Are you sure you want to "),
                      TextSpan(
                        text: "$text ",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.green, // 🔴 Red Color Here
                        ),
                      ),
                      TextSpan(
                          text:
                          "${connection.connectorProfile?.verificationDetails?.name ?? "N/A"}?",
                          style: MyTexts.medium15.copyWith(
                            color: MyColors.black,
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [

                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Get.find<ConnectionInboxController>().acceptConnection(
                            connection.id ?? "",
                          );
                          Navigator.pop(context);
                        },
                        buttonName: 'Confirm',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.primary,
                      ),
                    ),
                    SizedBox(width: 2.w),

                    Expanded(
                      child: RoundedButton(
                        onTap: () => Navigator.pop(context),
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.primary,
                        color: MyColors.white,
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

  static void showBlockDialog(BuildContext context, IncomingConnection connection, String? text,IconData? icons) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: getImageView(
                    //     finalUrl:
                    //         APIConstants.bucketUrl + (connection.merchantProfileImageUrl ?? ""),
                    //     height: 36,
                    //     width: 36,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icons,size: 25,),
                        // Text(
                        //   "${connection.merchantProfile?.businessName}",
                        //   style: MyTexts.medium14.copyWith(color: MyColors.black),
                        //   textAlign: TextAlign.center,
                        // ),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.location_on_rounded,
                        //       size: 14,
                        //       color: MyColors.veryDarkGray,
                        //     ),
                        //     const Gap(4),
                        //     Text(
                        //       "${connection.merchantProfile?.businessName}",
                        //       style: MyTexts.regular13.copyWith(color: MyColors.black),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: MyTexts.medium15.copyWith(
                      color: MyColors.black,
                    ),
                    children: [
                      const TextSpan(text: "Are you sure you want to "),
                      TextSpan(
                        text: "$text ",
                        style: MyTexts.medium16.copyWith(
                          color: Colors.red, // 🔴 Red Color Here
                        ),
                      ),
                      TextSpan(
                          text:
                          "${connection.connectorProfile?.verificationDetails?.name ?? "N/A"}?",
                          style: MyTexts.medium15.copyWith(
                            color: MyColors.black,
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [

                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          if (text == "Block") {
                            Get.find<ConnectionInboxController>().blockConnection(
                              connection.id ?? "",
                            );
                            Navigator.pop(context);
                          } else if (text == "Decline") {
                            Get.find<ConnectionInboxController>().rejectConnection(
                              connection.id ?? "",
                            );
                            Navigator.pop(context);
                          } else {
                            Get.find<ConnectionInboxController>().removeConnection(
                              connection.id ?? "",
                            );
                            Navigator.pop(context);
                          }
                        },
                        buttonName: text ?? "",
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.red,
                      ),
                    ),
                    SizedBox(width: 2.w),

                    Expanded(
                      child: RoundedButton(
                        onTap: () => Navigator.pop(context),
                        buttonName: 'No',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.white,
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
  static void showBlockDialogOutgoing(BuildContext context, OutgoingConnection connection, String? text,IconData? icons) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: getImageView(
                    //     finalUrl:
                    //         APIConstants.bucketUrl + (connection.merchantProfileImageUrl ?? ""),
                    //     height: 36,
                    //     width: 36,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icons,size: 25,),
                        // Text(
                        //   "${connection.merchantProfile?.businessName}",
                        //   style: MyTexts.medium14.copyWith(color: MyColors.black),
                        //   textAlign: TextAlign.center,
                        // ),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.location_on_rounded,
                        //       size: 14,
                        //       color: MyColors.veryDarkGray,
                        //     ),
                        //     const Gap(4),
                        //     Text(
                        //       "${connection.merchantProfile?.businessName}",
                        //       style: MyTexts.regular13.copyWith(color: MyColors.black),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: MyTexts.medium15.copyWith(
                      color: MyColors.black,
                    ),
                    children: [
                      const TextSpan(text: "Are you sure you want to "),
                      TextSpan(
                        text: "$text ",
                        style: MyTexts.medium16.copyWith(
                          color: Colors.red, // 🔴 Red Color Here
                        ),
                      ),
                      TextSpan(
                        text:
                        "${connection.merchantProfile?.businessName ?? "N/A"}?",
                          style: MyTexts.medium15.copyWith(
                            color: MyColors.black,
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [

                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          if (text == "Block") {
                            // Get.find<ConnectionInboxController>().blockConnection(
                            //   connection.id ?? "",
                            // );
                            Navigator.pop(context);
                          } else if (text == "Decline") {
                            Get.find<ConnectionInboxController>().rejectConnection(
                              connection.id ?? "",
                            );
                            Navigator.pop(context);
                          }
                          else if(text=="Withdraw"){
                            // Get.find<ConnectionInboxController>().withdrawRequest(connection.id ?? "");
                            Navigator.pop(context);
                          }
                          else {
                            Get.find<ConnectionInboxController>().removeConnection(
                              connection.id ?? "",
                            );
                            Navigator.pop(context);
                          }
                        },
                        buttonName: "Yes" ?? "",
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.primary,
                      ),
                    ),
                    SizedBox(width: 2.w),

                    Expanded(
                      child: RoundedButton(
                        onTap: () => Navigator.pop(context),
                        buttonName: 'No',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        fontColor: MyColors.primary,
                        color: MyColors.white,
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
