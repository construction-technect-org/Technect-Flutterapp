import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/model/analysis_model.dart';
import 'package:http/http.dart' as http;

class AnalysisService {
  final ApiManager _apiManager = ApiManager();

  Future<AnalysisModel?> fetchAllAnalysis({
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
  }) async {
    try {
      final par = {
        "startMonth": startMonth,
        "startYear": startYear,
        "endMonth": endMonth,
        "endYear": endYear,
      };
      final response = await _apiManager.get(
        url: myPref.role.val == "partner"
            ? APIConstants.merchantAnalytics
            : APIConstants.connectorAnalytics,
        params: par,
      );
      if (response != null) {
        return AnalysisModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching analysis: $e");
    }
    return null;
  }

  Future<AnalysisModel?> fetchAllAnalysisByPeriod({required String period}) async {
    try {
      final par = {"period": period};
      final response = await _apiManager.get(
        url: myPref.role.val == "partner"
            ? APIConstants.merchantAnalytics
            : APIConstants.connectorAnalytics,
        params: par,
      );
      if (response != null) {
        return AnalysisModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching analysis: $e");
    }
    return null;
  }

  Future<AnalysisModel?> fetchAllCRMAnalysis({
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
  }) async {
    try {
      final par = {
        "startMonth": startMonth,
        "startYear": startYear,
        "endMonth": endMonth,
        "endYear": endYear,
      };
      final response = await _apiManager.get(url: APIConstants.crmAnalytics, params: par);
      if (response != null) {
        return AnalysisModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching analysis: $e");
    }
    return null;
  }

  Future<AnalysisModel?> fetchAllCRMAnalysisByPeriod({required String period}) async {
    try {
      final par = {"period": period};
      final response = await _apiManager.get(url: APIConstants.crmAnalytics, params: par);
      if (response != null) {
        return AnalysisModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching analysis: $e");
    }
    return null;
  }

  Future<Uint8List?> fetchReportPdfByPeriod({
    String? period,
    required String token,
    required bool isPeriod,
    String? startMonth,
    String? startYear,
    String? endMonth,
    String? endYear,
  }) async {
    try {
      final uri =
          Uri.parse(
            "${ApiManager.baseUrl}${myPref.role.val == "partner" ? APIConstants.merchantReport : APIConstants.connectorReport}",
          ).replace(
            queryParameters: isPeriod
                ? {"period": period ?? ""}
                : {
                    "startMonth": startMonth ?? "",
                    "startYear": startYear ?? "",
                    "endMonth": endMonth ?? "",
                    "endYear": endYear ?? "",
                  },
          );

      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        log("Failed to fetch PDF. Status: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching PDF: $e");
    }
    return null;
  }

  Future<Uint8List?> fetchCRMReportPdfByPeriod({
    String? period,
    required String token,
    required bool isPeriod,
    String? startMonth,
    String? startYear,
    String? endMonth,
    String? endYear,
  }) async {
    try {
      final uri = Uri.parse("${ApiManager.baseUrl}${APIConstants.crmAnalyticsPdf}").replace(
        queryParameters: isPeriod
            ? {"period": period ?? ""}
            : {
                "startMonth": startMonth ?? "",
                "startYear": startYear ?? "",
                "endMonth": endMonth ?? "",
                "endYear": endYear ?? "",
              },
      );

      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        log("Failed to fetch PDF. Status: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching PDF: $e");
    }
    return null;
  }
}
