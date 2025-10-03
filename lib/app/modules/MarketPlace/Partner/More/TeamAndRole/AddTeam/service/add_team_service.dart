import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpPassword/model/SignUpModel.dart';

class AddTeamService {
  ApiManager apiManager = ApiManager();

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

  Future<Map<String, dynamic>> deleteTeamMember(int teamMemberId) async {
    try {
      final response = await apiManager.delete(
        url: "${APIConstants.team}/$teamMemberId",
      );
      return Map<String, dynamic>.from(response);
    } catch (e, st) {
      throw Exception('Error deleting team member: $e , $st');
    }
  }
}
