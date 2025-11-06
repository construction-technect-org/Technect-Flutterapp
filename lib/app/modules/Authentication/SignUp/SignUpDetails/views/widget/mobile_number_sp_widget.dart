import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MobileNumberSpWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String countryCode)? onCountryCodeChanged;
  final TextEditingController number;
  final String? initialCountryCode;
  final RxString? customErrorMessage;
  final RxInt isValid;

  MobileNumberSpWidget({
    required this.number,
    super.key,
    required this.isValid,
    this.customErrorMessage,
    required this.formKey,
    this.initialCountryCode = 'IN',
    this.onCountryCodeChanged,
  });

  final controller = SignUpDetailsController.to;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Display selected country code + number ---
            SizedBox(
              width: double.infinity,
              // ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => IntlPhoneField(
                        initialCountryCode: initialCountryCode,
                        flagsButtonMargin: const EdgeInsets.all(8),
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        cursorColor: MyColors.lightBlue,
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: MyColors.primary,
                        ),
                        dropdownIconPosition: IconPosition.trailing,
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.primary,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),

                        decoration: InputDecoration(
                          errorText:
                              (customErrorMessage?.value.isNotEmpty == true)
                              ? customErrorMessage!.value
                              : null,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  (isValid.value == 0 ||
                                      (customErrorMessage?.value.isNotEmpty ==
                                          true))
                                  ? Colors.red
                                  : MyColors.textFieldBorder,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  (customErrorMessage?.value.isNotEmpty == true)
                                  ? Colors.red
                                  : MyColors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.red33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.red33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isDense: true,
                          counterText: "",
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          hintText: "Enter your phone number",
                          hintStyle: MyTexts.medium13.copyWith(
                            color: MyColors.primary.withValues(alpha: 0.5),
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          errorStyle: MyTexts.medium13.copyWith(
                            color: MyColors.red33,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                        // onSubmitted: onSubmitted,
                        pickerDialogStyle: PickerDialogStyle(
                          searchFieldCursorColor: MyColors.primary,
                          backgroundColor: Colors.white,
                          countryNameStyle: MyTexts.medium14.copyWith(
                            color: Colors.black,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          countryCodeStyle: MyTexts.medium14.copyWith(
                            color: Colors.black,

                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          listTilePadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          searchFieldPadding: const EdgeInsets.all(10),
                          searchFieldInputDecoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            filled: true,
                            fillColor: MyColors.textFieldDivider.withValues(
                              alpha: 0.1,
                            ),
                            hintText: "Search Country",
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              color: MyColors.primary,
                            ),
                            hintStyle: MyTexts.medium14.copyWith(
                              color: MyColors.textFieldDivider,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: MyColors.textFieldBorder,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: MyColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        controller: number,
                        onChanged: (phone) {
                          // Clear error message when user types/changes number
                          if (customErrorMessage?.value.isNotEmpty == true) {
                            customErrorMessage?.value = "";
                          }
                          if (isValid.value != -1) {
                            isValid.value = -1;
                          }

                          if (phone.number.isEmpty) {
                            isValid.value = 0;
                          } else {
                            isValid.value = -1; // Reset validation state
                          }

                          if (onCountryCodeChanged != null) {
                            onCountryCodeChanged!(phone.countryCode);
                          }
                        },
                        onTap: () {
                          // Clear error when user taps to edit
                          if (customErrorMessage?.value.isNotEmpty == true) {
                            customErrorMessage?.value = "";
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(16),

            // --- Dial Pad ---
            StatefulBuilder(
              builder: (context, setState) {
                void appendDigit(String d) {
                  final currentText = number.text;
                  if (currentText.length >= 10) return;

                  // Clear error message when adding digit
                  if (customErrorMessage?.value.isNotEmpty == true) {
                    customErrorMessage?.value = "";
                  }
                  if (isValid.value != -1) {
                    isValid.value = -1;
                  }

                  // Get cursor position if available
                  final selection = number.selection;
                  final cursorPosition = selection.isValid
                      ? selection.baseOffset
                      : currentText.length;

                  // Insert digit at cursor position
                  final newText =
                      currentText.substring(0, cursorPosition) +
                      d +
                      currentText.substring(cursorPosition);
                  number.text = newText;

                  // Set cursor position after inserted digit
                  number.selection = TextSelection.collapsed(
                    offset: cursorPosition + 1,
                  );
                  setState(() {});
                }

                void backspace() {
                  final currentText = number.text;
                  if (currentText.isEmpty) return;

                  // Clear error message when deleting
                  if (customErrorMessage?.value.isNotEmpty == true) {
                    customErrorMessage?.value = "";
                  }
                  if (isValid.value != -1) {
                    isValid.value = -1;
                  }

                  // Get cursor position
                  final selection = number.selection;
                  final cursorPosition = selection.isValid
                      ? selection.baseOffset
                      : currentText.length;

                  if (cursorPosition > 0) {
                    // Delete character before cursor
                    final newText =
                        currentText.substring(0, cursorPosition - 1) +
                        currentText.substring(cursorPosition);
                    number.text = newText;

                    // Set cursor position after deleted character
                    number.selection = TextSelection.collapsed(
                      offset: cursorPosition - 1,
                    );
                  }
                  setState(() {});
                }

                Future<void> doContinue() async {
                  isValid.value = -1;
                  customErrorMessage?.value = "";

                  final mobileNumber = number.text.trim();

                  // Validate mobile number (required field)
                  final mobileError = Validate.validateMobileNumber(
                    mobileNumber,
                  );
                  if (mobileError != null) {
                    customErrorMessage?.value = mobileError;
                    isValid.value = 1;
                    return;
                  }

                  if (formKey.currentState!.validate()) {
                    hideKeyboard();

                    if (controller.isNavigatingToOtp.value) return;
                    if (Get.currentRoute == Routes.OTP_Verification) return;

                    controller.isNavigatingToOtp.value = true;
                    try {
                      controller.resetOtpState();
                      final sent = await controller.verifyMobileNumber();
                      if (!sent) return;

                      if (Get.isBottomSheetOpen == true) Get.back();
                      controller.resetOtpState();
                      await Get.toNamed(Routes.OTP_Verification);
                    } finally {
                      controller.isNavigatingToOtp.value = false;
                    }
                  }
                }

                Widget buildKey(Widget child, {required VoidCallback onTap}) {
                  return InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: MyColors.white,
                        border: Border.all(color: MyColors.textFieldBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: child,
                    ),
                  );
                }

                final keys = <Widget>[
                  for (var i = 1; i <= 9; i++)
                    buildKey(
                      Text('$i', style: MyTexts.medium18),
                      onTap: () => appendDigit('$i'),
                    ),
                  buildKey(
                    const Icon(
                      Icons.backspace_outlined,
                      color: MyColors.primary,
                    ),
                    onTap: backspace,
                  ),
                  buildKey(
                    Text('0', style: MyTexts.medium18),
                    onTap: () => appendDigit('0'),
                  ),
                  buildKey(
                    Text(
                      'Next',
                      style: MyTexts.medium16.copyWith(color: MyColors.primary),
                    ),
                    onTap: doContinue,
                  ),
                ];

                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.3,
                  children: keys,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
