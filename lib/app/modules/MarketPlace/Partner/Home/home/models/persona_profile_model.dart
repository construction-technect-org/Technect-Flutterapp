class PersonaProfileModel {
  bool? success;
  List<Personas>? personas;

  PersonaProfileModel({this.success, this.personas});

  PersonaProfileModel.fromJson(Map json) {
    success = json['success'];
    final personasJson = json['personas'];

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
      data['personas'] = this.personas?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Personas {
  String? profileType;
  String? profileId;
  String? profileName;
  String? teamRole;
  String? profileStatus;

  Personas({
    this.profileType,
    this.profileId,
    this.profileName,
    this.teamRole,
    this.profileStatus,
  });

  Personas.fromJson(Map json) {
    profileType = json['profileType'];
    profileId = json['profileId'];
    profileName = json['profileName'];
    teamRole = json['teamRole'];
    profileStatus = json['profileStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileType'] = this.profileType;
    data['profileId'] = this.profileId;
    data['profileName'] = this.profileName;
    data['teamRole'] = this.teamRole;
    data['profileStatus'] = this.profileStatus;
    return data;
  }
}
