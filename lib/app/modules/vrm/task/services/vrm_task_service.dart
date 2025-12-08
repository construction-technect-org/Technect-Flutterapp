import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/model/vrm_lead_model.dart';

class VrmTaskService {
  final ApiManager _apiManager = ApiManager();

  /// Fetch all leads from connector/lead API
  Future<VrmAllLeadModel> fetchAllLeads() async {
    final resp = await _apiManager.get(url: APIConstants.connectorLead);
    return VrmAllLeadModel.fromJson(resp);
  }
}
