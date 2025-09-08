import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/ProductModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/SubCategoryModel.dart';

class AddProductService {
  ApiManager apiManager = ApiManager();


// MainCategory
  Future<MainCategoryModel> mainCategory() async {
    try {
      final response = await apiManager.get(
        url:'${APIConstants.getMainCategories}',
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
      final response = await apiManager.get(url: "${APIConstants.getProducts}$subCategoryId");
      return ProductModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in productsBySubCategory: $e , $st');
    }
  }

 
}
