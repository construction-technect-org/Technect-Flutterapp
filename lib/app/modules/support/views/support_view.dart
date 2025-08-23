import 'package:construction_technect/app/core/utils/imports.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Support Screen', style: MyTexts.light22),
            SizedBox(height: 2.h),
            Text(
              'Get help and support here',
              style: MyTexts.medium16.copyWith(color: MyColors.greyDetails),
            ),
          ],
        ),
      ),
    );
  }
}
