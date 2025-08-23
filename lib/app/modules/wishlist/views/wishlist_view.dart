import 'package:construction_technect/app/core/utils/imports.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wishlist Screen', style: MyTexts.light22),
            SizedBox(height: 2.h),
            Text(
              'Your saved items will appear here',
              style: MyTexts.medium16.copyWith(color: MyColors.greyDetails),
            ),
          ],
        ),
      ),
    );
  }
}
