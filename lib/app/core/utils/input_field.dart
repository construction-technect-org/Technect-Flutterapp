import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

bool isValidEmail(String? email) {
  if (email == null || email.isEmpty) return false;
  return RegExp(
    r'^[A-Za-z0-9._%+-]*[A-Za-z]+[A-Za-z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter email";
  }
  if (!isValidEmail(value.trim())) {
    return "Please enter a valid email address";
  }
  return null;
}

String? validateName(String? value, {String fieldName = "Name"}) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter $fieldName";
  }
  if (value.trim().length < 2) {
    return "$fieldName must be at least 2 characters long";
  }
  if (!RegExp(r'^[A-Z][a-zA-Z]*$').hasMatch(value.trim())) {
    return "$fieldName must start with uppercase and contain only letters";
  }
  return null;
}

class NameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    if (newText.isNotEmpty) {
      newText =
          newText[0].toUpperCase() +
          (newText.length > 1 ? newText.substring(1).toLowerCase() : '');
    }
    final int diff = newValue.text.length - newText.length;
    int newOffset = newValue.selection.baseOffset - diff;

    newOffset = newOffset.clamp(0, newText.length);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text.replaceAll(' ', '').toLowerCase();
    final int diff = newValue.text.length - newText.length;
    int newOffset = newValue.selection.baseOffset - diff;
    newOffset = newOffset.clamp(0, newText.length);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
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
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CommonTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final bool showDivider; // <-- new
  final Widget? suffixIcon, suffix;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final String? headerText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;

  final double? borderRadius;
  final double? suffixPadding;
  final Function(String?)? onChange;
  final Function(String?)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final bool readOnly;
  final bool? isRed;
  final bool isBorder;
  final bool? enable;
  final Color? bgColor;
  final List<TextInputFormatter>? inputFormatters;
  final BoxConstraints? suffixIconConstraints;

  const CommonTextField({
    super.key,
    this.enable,
    this.suffix,
    this.onFieldSubmitted,
    this.borderRadius,
    this.prefixIcon,
    this.textCapitalization,
    this.suffixIcon,
    this.suffixPadding,
    this.bgColor,
    this.isBorder = true,
    this.isRed = true,
    this.maxLength,
    this.onTap,
    this.hintText = "",
    this.focusNode,
    this.onEditingComplete,
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
    this.headerText,
    this.suffixIconConstraints,
    this.showDivider = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((headerText ?? "").isNotEmpty)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    headerText ?? "",
                    style: MyTexts.medium14.copyWith(color: MyColors.gra54),
                  ),
                  // if (isRed == true)
                  //   Text(
                  //     '*',
                  //     style: MyTexts.medium14.copyWith(color: MyColors.red33),
                  //   ),
                ],
              ),
              const Gap(5),
            ],
          ),
        TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          style: MyTexts.medium15.copyWith(color: MyColors.primary),

          autofillHints: autofillHints,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          maxLength: maxLength,
          cursorColor: MyColors.lightBlue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          maxLines: maxLine ?? 1,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType ?? TextInputType.name,
          onChanged: (val) => onChange?.call(val),
          validator: validator,
          enabled: enable ?? true,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: suffixPadding ?? 16,
                    ),
                    child: suffixIcon,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.grayEA),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.black),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.red33),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.red33),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            isDense: true,
            filled: true,
            fillColor: bgColor ?? Colors.white,
            counterText: "",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            errorStyle: MyTexts.medium13.copyWith(color: MyColors.red33),
            errorMaxLines: 2,
            hintText: hintText,
            hintStyle: MyTexts.medium13.copyWith(
              color: MyColors.primary.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
