import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/Report/model/analysis_model.dart';

class AnalysisService {
  final ApiManager _apiManager = ApiManager();

  Future<AnalysisModel?> fetchAllAnalysis(
  {
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
}
      ) async {
    try {
      final par={
        "startMonth":startMonth,
        "startYear":startYear,
        "endMonth":endMonth,
        "endYear":endYear,
      };
      final response = await _apiManager.get(url: APIConstants.merchantAnalytics,params: par);
      if (response != null) {
        return AnalysisModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }


  Future<AnalysisModel?> fetchAllAnalysisByPeriod(
      {
        required String period
      }
      ) async {
    try {
      final par={
        "period":period,
      };
      final response = await _apiManager.get(url: APIConstants.merchantAnalytics,params: par);
      if (response != null) {
        return AnalysisModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }
}
