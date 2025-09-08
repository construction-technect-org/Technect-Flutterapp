import 'package:construction_technect/app/core/utils/imports.dart';

import '../models/team_detail_model.dart';

class TeamDetailsService {
  ApiManager apiManager = ApiManager();

  Future<TeamDetailsModel> teamDetail(String teamId) async {
    try {
      final response = await apiManager.get(
        url:'${APIConstants.teamDetail}/$teamId',
      );
      return TeamDetailsModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

}
