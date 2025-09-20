import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

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
                    style: MyTexts.regular16.copyWith(
                      color: MyColors.lightBlue,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  if(isRed==true)
                  Text(
                    '*',
                    style: MyTexts.regular16.copyWith(color: Colors.red),
                  ),
                ],
              ),
              const Gap(5),
            ],
          ),
        TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          style: MyTexts.medium16.copyWith(
            color: MyColors.primary,
            fontFamily: MyTexts.Roboto,
          ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: suffixIcon,
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.textFieldBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            filled: true,
            fillColor: bgColor??Colors.white,
            counterText: "",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            errorStyle: MyTexts.regular13.copyWith(
              color: Colors.red,
              fontFamily: MyTexts.Roboto,
            ),
            hintText: hintText,
            hintStyle: MyTexts.regular16.copyWith(
              color: MyColors.primary.withValues(alpha: 0.5),
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
      ],
    );
  }
}
