import 'package:construction_technect/app/core/utils/imports.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.validator,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.textFieldBorder),
      ),
      child: TextField(
        controller: controller,
        style: MyTexts.extraBold16.copyWith(
          height: 36 / 16,
          color: MyColors.primary,
        ),
        cursorHeight: 20,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintText != null
              ? MyTexts.medium16.copyWith(color: MyColors.grey)
              : null,
          border: InputBorder.none,
          suffixIcon: suffix,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
