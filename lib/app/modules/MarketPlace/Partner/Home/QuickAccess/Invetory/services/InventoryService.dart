import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';

class InventoryService {
  ApiManager apiManager = ApiManager();

  Future<AllServiceModel> getServiceList() async {
    try {
      final response = await apiManager.get(url: APIConstants.getServiceList);
      return AllServiceModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in productsBySubCategory: $e , $st');
    }
  }
}
