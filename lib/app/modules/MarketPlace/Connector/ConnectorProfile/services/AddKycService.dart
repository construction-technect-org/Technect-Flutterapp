import 'dart:convert';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/AddkycModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/PocModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class AddKycService {
  ApiManager apiManager = ApiManager();

  Future<AddKycModel> connectorAddKYC({
    String? aadhaar,
    String? panCard,
  }) async {
    try {
      final data = {
        "aadhaar_number": aadhaar ?? "",
        "pan_number": panCard ?? "",
      };
      final response = await apiManager.postObject(
        url: APIConstants.connectorCreate,
        body: data,
      );
      return AddKycModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in createProduct: $e , $st');
    }
  }

  Future<String?> getProfileId() async {
    try {
      final response = await apiManager.get(url: '/${APIConstants.getPersonaList}');
      // Access personas list
      final List personas = response["personas"] ?? [];
      if (personas.isNotEmpty) {
        return personas[0]["profileId"]?.toString();
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }

  Future<PocModel> getPointOfContact(String profileId) async {
    try {
      final response = await apiManager.get(
        url: "/${APIConstants.getConnectorProfile}/$profileId",
      );
      final PocModel data=  PocModel.fromJson(response);
      return data;
    } catch (e) {
      rethrow;
    }
  }
  // Future<PocModel> updatePOC(String profileId,Map<dynamic,dynamic> body) async {
  //   try {
  //     final response = await apiManager.putObject(
  //       url: "/${APIConstants.updateConnectorPocDetails}/$profileId",
  //       body: body,
  //     );
  //     final PocModel data=  PocModel.fromJson(response);
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
