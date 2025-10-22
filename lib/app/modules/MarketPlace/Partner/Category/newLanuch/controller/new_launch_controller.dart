import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Category/newLanuch/services/NewProductServices.dart';

class NewLaunchController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ConnectorSelectedProductModel?> productListModel =
      Rx<ConnectorSelectedProductModel?>(null);

  Future<void> fetchProductsFromApi() async {
    try {
      isLoading.value = true;
      productListModel.value = await NewProductServices().recentlyProduct();
    } catch (e) {
      isLoading.value = false;

      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> notifyMeApi({int? mID}) async {
    try {
      isLoading.value = true;
      final res = await ConnectorSelectedProductServices().notifyMe(mID: mID);
      if (res.success == true) {
        await fetchProductsFromApi();
      }
    } catch (e) {
      // No Error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToConnectApi({int? mID, int? pID, String? message}) async {
    try {
      isLoading.value = true;
      final res = await ConnectorSelectedProductServices().addToConnect(
        mID: mID,
        message: message,
        pID: pID,
      );
      if (res.success == true) {
        await fetchProductsFromApi();
      }
    } catch (e) {
      // No Error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> wishListApi({required int mID, required String status}) async {
    try {
      isLoading.value = true;
      final res = await WishListServices().wishList(mID: mID, status: status);
      if (res.success == true) {
        await fetchProductsFromApi();
      }
    } catch (e) {
      // No Error
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await fetchProductsFromApi();
    });
  }
}
