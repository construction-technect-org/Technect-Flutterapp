import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/models/delivery_address_model.dart';

class DeliveryLocationController extends GetxController {
  final CommonController commonController = Get.find<CommonController>();

  // Observable variables - redirected to central storage
  RxBool get isLoading => commonController.isLoadingAddresses;
  RxList<DeliveryAddressData> get addresses => commonController.addresses;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    await commonController.fetchAddresses();
  }

  // Add new address
  Future<void> addAddress() async {
    await Get.toNamed(Routes.ADD_DELIVERY_ADDRESS);
    fetchAddresses(); // Refresh central list after returning
  }
}
