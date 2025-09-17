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
  final Widget? prefix; // 👈 Added for start icon
  final int maxLines; // 👈 NEW for multi-line
  final bool? obscureText; // 👈 NEW for multi-line
  final bool? readOnly; // 👈 NEW for multi-line
  final TextCapitalization?
  textCapitalization; // 👈 NEW for text capitalization

  const CustomTextField({
    super.key,
    this.hintText,
    this.headerText,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText,
    this.readOnly=false,
    this.controller,
    this.onChanged,
    this.validator,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.textCapitalization,
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
            border: Border.all(color: MyColors.textFieldBorder),
          ),
          child: TextField(
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
          readOnly: readOnly??false,
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
                minWidth: 10, // 👈 shrink width
                minHeight: 10, // 👈 shrink height
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
