import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/model/vrm_dashboard_model.dart';

class VRMDashboardService {
  final ApiManager _apiManager = ApiManager();

  Future<VRMDashboardModel?> fetchDashboard() async {
    final resp = await _apiManager.get(url: APIConstants.vrmDashboard);
    if (resp == null) return null;
    return VRMDashboardModel.fromJson(resp['data'] ?? {});
  }
}
