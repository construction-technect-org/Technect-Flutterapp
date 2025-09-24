import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdown<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final Rx<T?> selectedValue;
  final String Function(T) itemLabel;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final Color? borderColor; // 🔹 NEW PARAMETER

  const CommonDropdown({
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.itemLabel,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.enabled = true,
    this.borderColor, // 🔹 add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ??
                (enabled ? const Color(0xFFA0A0A0) : Colors.grey.shade300), // 🔹 Use custom or fallback
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: items.contains(selectedValue.value)
                ? selectedValue.value
                : null,
            isExpanded: true,
            hint: Text(
              hintText,
              style: MyTexts.regular16.copyWith(
                color: enabled
                    ? MyColors.primary.withAlpha(120)
                    : Colors.grey.shade400,
                fontFamily: MyTexts.Roboto,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            icon: enabled
                ? (suffix ??
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                      color: Colors.black,
                    ))
                : const Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: Colors.grey,
                  ),
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabel(item),
                  style: MyTexts.extraBold16.copyWith(
                    height: 36 / 16,
                    color: enabled ? MyColors.primary : Colors.grey.shade400,
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
          ),
        ),
      );
    });
  }
}
