import 'package:construction_technect/app/core/utils/imports.dart';

class NoPermissionWidget extends StatelessWidget {
  final String message;
  const NoPermissionWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock_outline, size: 64, color: MyColors.primary),
            ),
            const Gap(24),
            Text(
              'Access Restricted',
              style: MyTexts.bold20.copyWith(color: MyColors.fontBlack),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            Text(
              message,
              style: MyTexts.medium14.copyWith(color: MyColors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              'Please contact your administrator for access',
              style: MyTexts.regular12.copyWith(color: MyColors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
