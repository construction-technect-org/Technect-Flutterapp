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

  const CommonDropdown({
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.itemLabel,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFA0A0A0)), // same as text field
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: items.contains(selectedValue.value) ? selectedValue.value : null,
            isExpanded: true,
            hint: Text(
              hintText,
              style: hintText != null
                  ? MyTexts.medium16.copyWith(color: MyColors.grey)
                  : null,
            ),
            icon:
                suffix ??
                const Icon(Icons.keyboard_arrow_down, size: 28, color: Colors.black),
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabel(item),
                  style: MyTexts.extraBold16.copyWith(
                    height: 36 / 16,
                    color: MyColors.primary,
                  ),
                ),
              );
            }).toList(),
            onChanged: (T? newValue) {
              selectedValue.value = newValue;
            },
            // Match same padding as CustomTextField
            dropdownColor: MyColors.white,
          ),
        ), // SAME as TextField
      );
    });
  }
}
