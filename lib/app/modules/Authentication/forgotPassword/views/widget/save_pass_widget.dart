import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SavePassWidget extends StatelessWidget {
  const SavePassWidget({
    super.key,
    required this.state,
    required this.onChanged,
  });

  final RxBool state;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final rx = state;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Obx(
            () => GestureDetector(
              onTap: () {
                rx.value = !rx.value;
                onChanged.call(rx.value);
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: MyColors.grey),
                  color: rx.value ? MyColors.primary : Colors.transparent,
                ),
                child: rx.value
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ),
          ),
          const Gap(8),
          Text(
            "Remember Me",
            style: MyTexts.medium14.copyWith(color: MyColors.gra54),
          ),
        ],
      ),
    );
  }
}
