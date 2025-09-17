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
  final bool readOnly;
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
    this.suffixIcon,
    this.bgColor,
    this.isBorder = true,
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
                    style: MyTexts.n16w400.copyWith(color: MyColors.lightBlue),
                  ),
                  Text('*', style: MyTexts.light18.copyWith(color: Colors.red)),
                ],
              ),
              const Gap(5),
            ],
          ),
        TextFormField(
          style: MyTexts.n16w500.copyWith(color: MyColors.primary),
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
            prefixIcon: (prefixIcon != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: prefixIcon,
                  )
                : const SizedBox(),
            suffixIcon: (suffixIcon != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: suffixIcon,
                  )
                : const SizedBox(),
            enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: MyColors.textFieldBorder),
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
              borderRadius: BorderRadius.circular(10),),
            isDense: true,
            counterText: "",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            errorStyle:  MyTexts.n13w400.copyWith(color: Colors.red),
            hintText: hintText,
            hintStyle: MyTexts.n14w500.copyWith(
              color:MyColors.primary.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
