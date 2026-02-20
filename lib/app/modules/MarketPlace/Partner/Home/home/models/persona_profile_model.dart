class PersonaProfileModel {
  final bool? success;
  final List<Personas>? personas;

  PersonaProfileModel({
    this.success,
    this.personas,
  });

  PersonaProfileModel.fromJson(Map json) {
    success = json['success'];
    final personasJson = json['profiles'];

    if (personasJson is List) {
      personas = personasJson.map((e) => Personas.fromJson(e as Map)).toList();
    } else {
      personas = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.personas != null) {
      data['profiles'] = this.personas?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Personas {
  final String? profileType;
  final String? profileId;
  final String? teamRole;
  final String? profileStatus;

  Personas({this.profileType, this.profileId, this.profileName, this.teamRole, this.profileStatus});

  factory Personas.fromJson(Map<String, dynamic> json) {
    return Personas(
      profileType: json['profileType'],
      profileId: json['profileId'],
      teamRole: json['teamRole'],
      profileStatus: json['profileStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profileType": profileType,
      "profileId": profileId,
      "teamRole": teamRole,
      "profileStatus": profileStatus,
    };
  }
}