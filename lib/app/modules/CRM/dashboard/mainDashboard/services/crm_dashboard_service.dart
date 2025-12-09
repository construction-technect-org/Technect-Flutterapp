import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/model/dashboard_model.dart';

class CRMDashboardService {
  final ApiManager _apiManager = ApiManager();

  Future<DashboardModel> getDashboard() async {
    try {
      const String url = APIConstants.crmDashboard;

      debugPrint('Calling API: $url (fetching all dashboard types)');
      final response = await _apiManager.get(url: url);
      debugPrint('Dashboard Response: $response');

      return DashboardModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error fetching dashboard: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching dashboard: $e');
    }
  }
}
