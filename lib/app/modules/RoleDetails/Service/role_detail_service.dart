import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/RoleDetails/models/role_details_model.dart';

class RoleDetailService {
  ApiManager apiManager = ApiManager();

  Future<RoleDetailsModel> roleDetail(String roleId) async {
    try {
      final response = await apiManager.get(
        url:'${APIConstants.roleDetailById}/$roleId',
      );
      return RoleDetailsModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

}
