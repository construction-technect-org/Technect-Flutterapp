import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommonDropdown<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final Rx<T?> selectedValue;
  final String Function(T) itemLabel;
  final Widget? prefix;
  final String? headerText;
  final Widget? suffix;
  final ValueChanged<T?>? onChanged;
  final bool? isRed;
  final bool enabled;
  final Color? borderColor;
  final String? Function(T?)? validator; // ✅ supports form validation

  const CommonDropdown({
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.itemLabel,
    this.prefix,
    this.suffix,
    this.isRed = true,
    this.headerText,
    this.onChanged,
    this.enabled = true,
    this.borderColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
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
                    style: MyTexts.regular16.copyWith(
                      color: MyColors.lightBlue,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  if (isRed == true)
                    Text(
                      '*',
                      style: MyTexts.regular16.copyWith(color: Colors.red),
                    ),
                ],
              ),
              const Gap(5),
            ],
          ),
        Obx(() {
          return DropdownButtonFormField<T>(
            initialValue: items.contains(selectedValue.value)
                ? selectedValue.value
                : null,
            isExpanded: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: prefix != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: prefix,
                    )
                  : null,
              suffixIcon:
                  suffix ??
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: enabled ? Colors.black : Colors.grey,
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.textFieldBorder),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              isDense: true,
              filled: true,
              fillColor: enabled ? Colors.white : Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              errorStyle: MyTexts.regular13.copyWith(
                color: Colors.red,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            hint: Text(
              hintText,
              style: MyTexts.regular16.copyWith(
                color: MyColors.primary.withValues(alpha: 0.5),
                fontFamily: MyTexts.Roboto,
              ),
            ),
            // ✅ This ensures same hint style as TextField
            selectedItemBuilder: (context) {
              return items.map((item) {
                return Text(
                  itemLabel(item),
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.primary,
                    fontFamily: MyTexts.Roboto,
                  ),
                );
              }).toList();
            },
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabel(item),
                  style: MyTexts.medium16.copyWith(
                    color: enabled ? MyColors.primary : Colors.grey.shade400,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
              );
            }).toList(),
            onChanged: enabled
                ? (T? newValue) {
                    selectedValue.value = newValue;
                    onChanged?.call(newValue);
                  }
                : null,
            dropdownColor: MyColors.white,
          );
        }),
      ],
    );
  }
}
