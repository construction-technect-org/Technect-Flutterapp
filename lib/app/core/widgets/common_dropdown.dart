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
  final ValueChanged<T?>? onChanged; // 🔹 added callback
  final bool enabled; // 🔹 added enabled parameter

  const CommonDropdown({
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.itemLabel,
    this.prefix,
    this.suffix,
    this.onChanged, // 🔹 added
    this.enabled = true, // 🔹 default to enabled
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled ? const Color(0xFFA0A0A0) : Colors.grey.shade300,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: items.contains(selectedValue.value)
                ? selectedValue.value
                : null,
            isExpanded: true,
            hint: Text(
              hintText,
              style: MyTexts.medium16.copyWith(
                color: enabled ? MyColors.grey : Colors.grey.shade400,
              ),
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
