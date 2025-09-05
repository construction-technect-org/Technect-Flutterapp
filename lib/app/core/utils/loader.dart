import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:lottie/lottie.dart';

class LoaderLottie extends StatelessWidget {
  final RxBool isLoading;

  const LoaderLottie({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return Center(child: Lottie.asset('assets/animation/loading.json', width: 50.w));
      } else {
        return const SizedBox();
      }
    });
  }
}
