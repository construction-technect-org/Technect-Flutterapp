import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/model/vrm_lead_model.dart';

class VrmTaskService {
  final ApiManager _apiManager = ApiManager();

  Future<VrmAllLeadModel> fetchAllLeads() async {
    final resp = await _apiManager.get(url: APIConstants.vrmLead);
    return VrmAllLeadModel.fromJson(resp);
  }
}
