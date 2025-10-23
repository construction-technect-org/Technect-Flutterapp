import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Category/newLanuch/services/NewProductServices.dart';

class NewLaunchController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingWrapper = false.obs;
  Rx<ConnectorSelectedProductModel?> productListModel =
      Rx<ConnectorSelectedProductModel?>(null);

  Future<void> fetchProductsFromApi({bool? isLoad=false}) async {
    try {
      isLoading.value = isLoad??false;
      productListModel.value = await NewProductServices().recentlyProduct();
    } catch (e) {
      isLoading.value = false;

      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await fetchProductsFromApi(isLoad: true);
    });
  }
}
