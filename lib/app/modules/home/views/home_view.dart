import 'package:construction_technect/app/core/utils/imports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen', style: MyTexts.light22),
            SizedBox(height: 2.h),
            Text(
              'Welcome to Construction Technect',
              style: MyTexts.medium16.copyWith(color: MyColors.greyDetails),
            ),
          ],
        ),
      ),
    );
  }
}
