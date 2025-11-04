import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

void showErrorSheet(String errorText, {Function()? onTap}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    context: Get.context!,
    isScrollControlled: true,
    builder: (context) =>
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: MyColors.white,
          ),
          padding: const EdgeInsetsDirectional.only(
              start: 24, end: 24, top: 18, bottom: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Error",
                  style: MyTexts.medium20.copyWith(color: MyColors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  •",
                    style: MyTexts.medium16.copyWith(color: MyColors.black),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(5),
                  Expanded(
                    child: Text(
                      errorText,
                      style: MyTexts.medium16.copyWith(color: MyColors.black),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              const Gap(16),
              RoundedButton(
                  onTap: ()  {
                    Get.back();
                  },
                  buttonName: "Okay")
            ],
          ),
        ),
  );
}
