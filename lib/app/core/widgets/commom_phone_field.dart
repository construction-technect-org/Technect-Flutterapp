import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CommonPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final RxInt isValid;
  final String? initialCountryCode;
  final void Function(String countryCode)? onCountryCodeChanged;
  final Function(String countryCode)? onSubmitted;
  final VoidCallback? onTap;
  final String? headerText;
  final bool showDivider;
  final Color? bgColor;
  final double? borderRadius;
  final Widget? suffix;
  final RxString? customErrorMessage;
  final bool enableRealTimeValidation;
  final TextStyle? style;
  final bool? isRed;

  const CommonPhoneField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isValid,
    this.initialCountryCode = 'IN',
    this.onCountryCodeChanged,
    this.suffix,
    this.onSubmitted,
    this.headerText,
    this.showDivider = false,
    this.bgColor,
    this.borderRadius,
    this.customErrorMessage,
    this.enableRealTimeValidation = true,
    this.style,
    this.isRed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((headerText ?? "").isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      headerText ?? "",
                      style:
                          style ??
                          MyTexts.medium14.copyWith(
                            color: MyColors.gra54,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                    ),
                    if (isRed == true)
                      Text(
                        '*',
                        style: MyTexts.medium14.copyWith(color: MyColors.red33),
                      ),
                    // Text(
                    //   '*',
                    //   style: MyTexts.medium14.copyWith(color: MyColors.red33),
                    // ),
                  ],
                ),
                const Gap(5),
              ],
            ),

          AutofillGroup(
            child: IntlPhoneField(
              flagsButtonMargin: const EdgeInsets.all(8),
              controller: controller,
              focusNode: focusNode,
              initialCountryCode: initialCountryCode,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              cursorColor: MyColors.lightBlue,
              textInputAction: TextInputAction.next,
              dropdownIcon: const Icon(
                Icons.arrow_drop_down,
                color: MyColors.primary,
              ),
              dropdownIconPosition: IconPosition.trailing,
              style: MyTexts.medium16.copyWith(
                color: MyColors.primary,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
              disableLengthCheck: true,
              invalidNumberMessage: "",
              decoration: InputDecoration(
                suffixIcon: suffix,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        (isValid.value == 0 ||
                            isValid.value == 1 ||
                            (enableRealTimeValidation &&
                                customErrorMessage?.value.isNotEmpty == true))
                        ? Colors.red
                        : MyColors.textFieldBorder,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.black),
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
                hintText: "Enter your mobile number",
                hintStyle: MyTexts.medium13.copyWith(
                  color: MyColors.primary.withValues(alpha: 0.5),
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
                errorStyle: MyTexts.medium13.copyWith(
                  color: MyColors.red33,
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
              ),
              validator: (phone) {
                return null;
              },
              onSubmitted: onSubmitted,
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
                listTilePadding: const EdgeInsets.symmetric(horizontal: 10),
                searchFieldPadding: const EdgeInsets.all(10),
                searchFieldInputDecoration: InputDecoration(
                  isDense: true,
                  counterText: "",
                  filled: true,
                  fillColor: MyColors.textFieldDivider.withValues(alpha: 0.1),
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
                    borderSide: const BorderSide(color: MyColors.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onTap:
                  onTap ??
                  () {
                    // Clear error when user taps to edit
                    if (customErrorMessage?.value.isNotEmpty == true) {
                      customErrorMessage?.value = "";
                    }
                  },
              onChanged: (phone) {
                if (onCountryCodeChanged != null) {
                  onCountryCodeChanged!(phone.countryCode);
                }

                if (enableRealTimeValidation) {
                  final number = phone.number.trim();
                  if (number.isEmpty) {
                    customErrorMessage?.value = "";
                    isValid.value = -1;
                  } else {
                    final error = Validate.validateMobileNumber(number);
                    if (error != null) {
                      customErrorMessage?.value = error;
                      isValid.value = 1;
                    } else {
                      customErrorMessage?.value = "";
                      isValid.value = -1;
                    }
                  }
                } else {
                  if (customErrorMessage?.value.isNotEmpty == true) {
                    customErrorMessage?.value = "";
                  }
                  if (isValid.value != -1) {
                    isValid.value = -1;
                  }

                  if (phone.number.isEmpty) {
                    isValid.value = 0;
                  } else {
                    isValid.value = -1;
                  }
                }
              },
            ),
          ),
          if (isValid.value == 0 ||
              isValid.value == 1 ||
              (enableRealTimeValidation &&
                  customErrorMessage?.value.isNotEmpty == true))
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 6),
              child: Text(
                isValid.value == 0
                    ? "Please enter your mobile number"
                    : (customErrorMessage?.value.isNotEmpty == true
                          ? customErrorMessage!.value
                          : "Invalid mobile number"),
                style: MyTexts.medium13.copyWith(
                  color: MyColors.red33,
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
    });
  }
}
