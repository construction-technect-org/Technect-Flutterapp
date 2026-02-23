import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/marketplace_category_models.dart';

class MarketplaceCategoryService {
  final ApiManager _apiManager = ApiManager();

  /// Step 1: Fetch all modules for merchant
  Future<MarketplaceModuleResponse> getModules() async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.marketplaceModules,
        params: {'moduleFor': 'merchant', 'includeInactive': 'false'},
      );
      return MarketplaceModuleResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getModules: $e, $st');
    }
  }

  /// Step 2: Fetch main categories for a given moduleId
  Future<MarketplaceMainCategoryResponse> getMainCategories(String moduleId) async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.marketplaceMainCategories,
        params: {'moduleId': moduleId, 'includeInactive': 'false'},
      );
      return MarketplaceMainCategoryResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getMainCategories: $e, $st');
    }
  }

  /// Step 3: Fetch categories for a given mainCategoryId
  Future<MarketplaceCategoryResponse> getCategories(String mainCategoryId) async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.marketplaceCategories,
        params: {'mainCategoryId': mainCategoryId, 'includeInactive': 'false'},
      );
      return MarketplaceCategoryResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getCategories: $e, $st');
    }
  }

  /// Step 4: Fetch sub-categories for a given categoryId
  Future<MarketplaceSubCategoryResponse> getSubCategories(String categoryId) async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.marketplaceSubCategories,
        params: {'categoryId': categoryId, 'includeInactive': 'false'},
      );
      return MarketplaceSubCategoryResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getSubCategories: $e, $st');
    }
  }

  /// Step 5: Fetch category products for a given subCategoryId
  Future<MarketplaceCategoryProductResponse> getCategoryProducts(String subCategoryId) async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.marketplaceCategoryProducts,
        params: {'subCategoryId': subCategoryId, 'includeInactive': 'true'},
      );
      return MarketplaceCategoryProductResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getCategoryProducts: $e, $st');
    }
  }
}
