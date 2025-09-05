import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/loader.dart';

class LoaderWrapper extends StatelessWidget {
  final Widget child;
  final RxBool isLoading;

  const LoaderWrapper({super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        LoaderLottie(isLoading: isLoading),
      ],
    );
  }
}
