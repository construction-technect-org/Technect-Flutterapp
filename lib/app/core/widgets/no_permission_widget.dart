import 'package:construction_technect/app/core/utils/imports.dart';

class NoPermissionWidget extends StatelessWidget {
  final String message;
  const NoPermissionWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          style: MyTexts.medium14.copyWith(color: MyColors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
