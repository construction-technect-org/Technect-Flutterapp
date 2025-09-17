import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef OnValidation = String? Function(String? text);

bool isValidEmail(String? email) {
  if (email == null || email.isEmpty) return false;
  return RegExp(
    r'^[A-Za-z0-9._%+-]*[A-Za-z]+[A-Za-z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter password";
  }

  final List<String> errors = [];

  if (value.length < 8) {
    errors.add("• At least 8 characters");
  }

  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    errors.add("• At least 1 uppercase letter");
  }

  if (!RegExp(r'\d').hasMatch(value)) {
    errors.add("• At least 1 number");
  }

  if (!RegExp(r'[!@#\$&*~%^()_+=\[{\]};:<>|./?,-]').hasMatch(value)) {
    errors.add("• At least 1 special character");
  }

  if (errors.isNotEmpty) {
    return errors.join("\n"); // 🔥 show all errors together
  }

  return null; // ✅ valid password
}


bool isValidPassword(String? password) {
  if (password == null || password.isEmpty) return false;
  return RegExp(
    r'^(?=.*[A-Za-z])(?=.*[!@#$%^&*(),.?":{}|<>]).+$',
  ).hasMatch(password);
}

bool isValidUsername(String? username) {
  if (username == null || username.isEmpty) return false;
  return RegExp(
    r'^(?!.*[_.]{2})[a-zA-Z0-9](?:[a-zA-Z0-9._]{1,}[a-zA-Z0-9])?$',
  ).hasMatch(username);
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

class CommonTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Iterable<String>? autofillHints;
  String? hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool? obscureText;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? maxLength;
  final bool readOnly;
  final String? headerText;
  final bool? enable;

  final List<TextInputFormatter>? inputFormatters;

  CommonTextField({
    Key? key,
    this.enable,
    this.headerText,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.onTap,
    this.hintText = "",
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.onChange,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.maxLine,
    this.autofillHints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if ((headerText ?? "").isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    headerText ?? "",
                    style: MyTexts.light18.copyWith(color: MyColors.lightBlue),
                  ),
                  Text('*', style: MyTexts.light18.copyWith(color: Colors.red)),
                ],
              ),
              const Gap(8),
            ],
          ),
        TextFormField(
          style:  MyTexts.n14w500.copyWith(color:MyColors.black),
          autofillHints: autofillHints,
          autocorrect: true,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          onTap: onTap,
          maxLength: maxLength,
          cursorColor: MyColors.black,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          obscureText: obscureText!,
          maxLines: maxLine ?? 1,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType ?? TextInputType.name,
          onChanged: (val) {
            if (onChange != null) {
              onChange!(val);
            }
          },

          validator: (val) {
            if (validator != null) {
              return validator!(val);
            } else {
              return null;
            }
          },
          enabled: enable ?? true,
          decoration: InputDecoration(
            fillColor: MyColors.textFieldBorder,
            filled: true,
            counterText: "",
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.red, width: 1),

              borderRadius: BorderRadius.circular(14.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.red, width: 1),
              borderRadius: BorderRadius.circular(14.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:  MyColors.textFieldBorder, width: 1),
              borderRadius: BorderRadius.circular(14.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:  MyColors.primary, width: 1),
              borderRadius: BorderRadius.circular(14.0),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle:
            MyTexts.n14w500.copyWith(color:MyColors.grey),
            errorStyle: MyTexts.n14w500.copyWith(color:MyColors.red),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 24,
              maxHeight: 24,
              maxWidth: 36,
              minWidth: 36,
            ),
          ),
        ),
      ],
    );
  }
}
