import 'package:construction_technect/app/core/utils/imports.dart';

class AddTeamService {
  ApiManager apiManager = ApiManager();

  Future<void> addTeam({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      await apiManager.postMultipart(
        url: APIConstants.team,
        fields: fields,
        files: files,
      );
    } catch (e, st) {
      throw Exception('Error adding team: $e , $st');
    }
  }

  Future<void> updateTeam({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
    required String id,
  }) async {
    try {
      await apiManager.putMultipart(
        url: '${APIConstants.team}/$id',
        fields: fields,
        files: files,
      );
    } catch (e, st) {
      throw Exception('Error updating team: $e , $st');
    }
  }

  Future<void> deleteTeamMember(int teamMemberId) async {
    try {
      await apiManager.delete(url: "${APIConstants.team}/$teamMemberId");
    } catch (e, st) {
      throw Exception('Error deleting team member: $e , $st');
    }
  }
}
