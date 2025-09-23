import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddLocationManually/models/SavedAddressesModel.dart';

class ConnectorAddLocationManuallyController extends GetxController {
  // Form controllers
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityStateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  RxBool isSearching = false.obs;

  // Service

  RxList<SavedAddresses> addresses = <SavedAddresses>[].obs;

  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) return;
    isSearching.value = true;

    // Call your API here for places search...
    await Future.delayed(const Duration(seconds: 1));

    isSearching.value = false;
  }
}
