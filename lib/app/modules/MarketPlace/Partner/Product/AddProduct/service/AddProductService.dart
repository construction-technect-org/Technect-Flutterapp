import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/create_product.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';

class AddProductService {
  ApiManager apiManager = ApiManager();

  // MainCategory
  Future<MainCategoryModel> mainCategory() async {
    try {
      final response = await apiManager.get(
        url: APIConstants.getMainCategories,
      );
      return MainCategoryModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

  // SubCategory
  Future<SubCategoryModel> subCategory(int mainCategoryId) async {
    try {
      final response = await apiManager.get(
        url: "${APIConstants.getSubCategories}$mainCategoryId",
      );
      return SubCategoryModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in subCategory: $e , $st');
    }
  }

  // ---------------- Products by SubCategory ----------------
  Future<ProductModel> productsBySubCategory(int subCategoryId) async {
    try {
      final response = await apiManager.get(
        url: "${APIConstants.getProducts}$subCategoryId",
      );
      return ProductModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in productsBySubCategory: $e , $st');
    }
  }

  Future<GetFilterModel> getFilter(int subCategoryId) async {
    try {
      final response = await apiManager.get(
        url: "${APIConstants.getFilter}$subCategoryId",
      );
      return GetFilterModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in productsBySubCategory: $e , $st');
    }
  }

  Future<ApiResponse> createProduct({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.postMultipart(
        url: APIConstants.createProduct,
        fields: fields,
        files: files,
      );
      final data = response;
      final success = data["success"] ?? false;
      final message = data["message"] ?? "No message from server";

      return ApiResponse(success: success, message: message);
    } catch (e, st) {
      throw Exception('Error in createProduct: $e , $st');
    }
  }

  Future<ApiResponse> updateProduct({
    required int productId,
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.putMultipart(
        url: "${APIConstants.updateProduct}$productId",
        fields: fields,
        files: files,
      );

      final data = response;
      final success = data["success"] ?? false;
      final message = data["message"] ?? "No message from server";

      return ApiResponse(success: success, message: message);
    } catch (e, st) {
      debugPrint("❌ Error in updateProduct: $e");
      debugPrint("$st");
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
class ApiResponse {
  final bool success;
  final String? message;

  ApiResponse({required this.success, this.message});
}
