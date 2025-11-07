import 'package:construction_technect/app/core/utils/imports.dart';

class ReferController extends GetxController {
  final suggestionController = TextEditingController();
  RxInt rating = 0.obs;
  RxBool isLoading = false.obs;
}
