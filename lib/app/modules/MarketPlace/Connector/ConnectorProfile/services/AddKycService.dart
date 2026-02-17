import 'dart:convert';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/AddkycModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/PocModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/persona_profile_model.dart';
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

  Future<PersonaResponse> getProfileId() async {
    try {
      final response = await apiManager.get(url: '/${APIConstants.getPersonaList}');
      // Access personas list
      final data = PersonaResponse.fromJson(response);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<PocModel> getPointOfContact(String profileId) async {
    try {
      final response = await apiManager.get(
        url: "/${APIConstants.getConnectorProfile}",
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
