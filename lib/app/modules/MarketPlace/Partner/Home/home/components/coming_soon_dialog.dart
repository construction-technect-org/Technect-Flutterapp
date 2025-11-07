import 'package:construction_technect/app/core/utils/imports.dart';

class ComingSoonDialog {
  static void showComingSoonDialog({String? featureName}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: MyColors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.construction,
                  size: 40,
                  color: MyColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Coming Soon!',
                style: MyTexts.bold20.copyWith(color: MyColors.fontBlack),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                featureName != null
                    ? '$featureName feature is under development'
                    : 'This feature is under development',
                style: MyTexts.regular14.copyWith(color: MyColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Stay tuned for exciting updates!',
                style: MyTexts.regular12.copyWith(color: MyColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: RoundedButton(
                  onTap: () => Get.back(),
                  color: MyColors.primary,
                  fontColor: MyColors.white,
                  buttonName: 'Got it',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
