// lib/app/modules/AddTeam/service/add_team_service.dart

import 'dart:developer';
import 'dart:io';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/AddTeam/models/AddTeamModel.dart';

class AddTeamService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddTeamModel> createTeamMember({
    required String fullName,
    required String emailId,
    required String phoneNumber,
    required String address,
    required String state,
    required String city,
    required String pincode,
    required String aadharCardNumber,
    required String panCardNumber,
    required int teamRoleId,
    required bool isActive,
    File? profilePhoto,
    File? aadharCardPhoto,
    File? panCardPhoto,
  }) async {
    try {
      // ✅ Prepare fields
      final fields = {
        'full_name': fullName,
        'email_id': emailId,
        'phone_number': phoneNumber,
        'address': address,
        'state': state,
        'city': city,
        'pincode': pincode,
        'aadhar_card_number': aadharCardNumber,
        'pan_card_number': panCardNumber,
        'team_role_id': teamRoleId.toString(),
        'is_active': isActive.toString(),
      };

      // ✅ Prepare files
      final Map<String, String> files = {};
      if (profilePhoto != null) {
        files['profile_photo'] = profilePhoto.path;
      }
      if (aadharCardPhoto != null) {
        files['aadhar_card_photo'] = aadharCardPhoto.path;
      }
      if (panCardPhoto != null) {
        files['pan_card_photo'] = panCardPhoto.path;
      }

      // ✅ Send request using ApiManager
      final response = await _apiManager.postMultipart(
        url: APIConstants.addRole, // ⚠️ Make sure this constant points to the correct "add team" API, not "add role"
        fields: fields,
        files: files.isNotEmpty ? files : null,
      );

      log("CreateTeam Response: $response");

      return AddTeamModel.fromJson(response);
    } catch (e) {
      log("AddTeamService Error: $e");
      rethrow;
    }
  }
}
