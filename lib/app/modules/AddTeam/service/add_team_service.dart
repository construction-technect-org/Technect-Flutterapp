import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/SignUpDetails/model/OtpModel.dart';
import 'package:construction_technect/app/modules/SignUpPassword/model/SignUpModel.dart';

class AddTeamService {
  ApiManager apiManager = ApiManager();

  Future<OtpModel> team({required String mobileNumber}) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.team,
        body: addTeam,
      );
      return OtpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

  Future<SignUpModel> addTeam({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.postMultipart(
        url: APIConstants.team,
        fields: fields,
        files: files,
        //
      );
      return SignUpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in signup: $e , $st');
    }
  }

  Future<SignUpModel> updateTeam({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
    required String id,
  }) async {
    try {
      final response = await apiManager.putMultipart(
        url: '${APIConstants.team}/$id',
        fields: fields,
        files: files,
        //
      );
      return SignUpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in signup: $e , $st');
    }
  }
}
