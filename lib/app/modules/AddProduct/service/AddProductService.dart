import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/create_product.dart';
import 'package:construction_technect/app/modules/AddProduct/models/get_filter_model.dart';

class AddProductService {
  ApiManager apiManager = ApiManager();

  // MainCategory
  Future<MainCategoryModel> mainCategory() async {
    try {
      final response = await apiManager.get(url: APIConstants.getMainCategories);
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

  Future<CreateProductModel> createProduct({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.postMultipart(
        url: APIConstants.createProduct,
        fields: fields,
        files: files,
      );
      return CreateProductModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in signup: $e , $st');
    }
  }
}
