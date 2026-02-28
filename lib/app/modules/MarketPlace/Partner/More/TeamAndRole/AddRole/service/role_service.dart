import 'package:construction_technect/app/core/apiManager/endpoints.dart';
import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/permissions_model.dart';
import 'package:get/get.dart';

class AddRoleService extends GetxService {
  final ManageApi _manageApi = Get.find<ManageApi>();

  Future<PermissionsModel> getPermisssions(String pFor) async {
    try {
      final response = await _manageApi.get(
        url: '${Endpoints.getAllPermissionApi}$pFor',
      );
      return PermissionsModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Permissions: $e , $st');
    }
  }

}
