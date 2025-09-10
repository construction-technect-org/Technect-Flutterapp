import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/ProductManagement/service/product_management_service.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductManagementController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ProductListModel> productModel = ProductListModel().obs;
  RxList<Product> productList = <Product>[].obs;
  @override
  void onInit() {
    super.onInit();

    fetchProducts();
  }

  final ProductManagementService _service = ProductManagementService();


  void searchProduct(String value){
    if(value.isEmpty){
      productList.clear();
      productList.addAll(productModel.value.data?.products??[]);

    }else{
      productList.clear();
productList.value=(productModel.value.data?.products??[]).where((product) {
  return (product.productName??'').toLowerCase().contains(value.toLowerCase()) ||
      (product.brand??'').toLowerCase().contains(value.toLowerCase());
}).toList();
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final result = await _service.getProductList();

      if (result.success == true) {
        productModel.value = result;
        productList.addAll(productModel.value.data?.products??[]);
      }
    } catch (e) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  RxList<String> specifications =
      <String>[
        "Particle size ranging from 0 to 4.75mm.",
        "High compressive strength.",
        "Free from impurities.",
        "Durable and long-lasting.",
      ].obs;

  /// Function to navigate to edit product
  void onEditProduct() {
    Get.toNamed(Routes.ADDP_PRODUCT, arguments: {"isEdit": true});
  }
}
