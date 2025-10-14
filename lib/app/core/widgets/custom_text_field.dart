import 'package:construction_technect/app/core/utils/imports.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? headerText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? prefix;
  final int maxLines;
  final bool? obscureText;
  final bool? readOnly;
  final TextCapitalization? textCapitalization;
  final Color? borderColor; // 👈 New parameter for optional border color

  const CustomTextField({
    super.key,
    this.hintText,
    this.headerText,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.textCapitalization,
    this.borderColor, // 👈 Initialize here
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
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                  Text(
                    '*',
                    style: MyTexts.regular16.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
            ],
          ),
        Container(
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor ?? MyColors.textFieldBorder, // 👈 Use here
            ),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            obscureText: obscureText ?? false,
            style: MyTexts.extraBold16.copyWith(
              height: 36 / 16,
              color: MyColors.primary,
            ),
            cursorHeight: 20,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            maxLines: maxLines,
            readOnly: readOnly ?? false,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintText != null
                  ? MyTexts.medium16.copyWith(color: MyColors.grey)
                  : null,
              border: InputBorder.none,

              suffixIcon: suffix,
              prefixIcon: prefix,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 10,
                minHeight: 10,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
