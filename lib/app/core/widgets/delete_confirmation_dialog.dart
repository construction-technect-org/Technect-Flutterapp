import 'package:construction_technect/app/core/utils/imports.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cancelButtonText;
  final String deleteButtonText;
  final VoidCallback onDelete;
  final Color? deleteButtonColor;

  const DeleteConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.cancelButtonText = 'Go Back',
    this.deleteButtonText = 'Delete',
    required this.onDelete,
    this.deleteButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            title,
            style: MyTexts.medium20.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: MyTexts.regular16.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
          const SizedBox(height: 20),
          RoundedButton(
            buttonName: cancelButtonText,
            onTap: () {
              Get.back();
            },
          ),
          const SizedBox(height: 10),
          RoundedButton(
            buttonName: deleteButtonText,
            color: deleteButtonColor ?? const Color(0xFFD04F4F),
            onTap: () {
              Get.back();
              onDelete();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
