class PersonaResponse {
  final bool success;
  final List<Persona> personas;

  PersonaResponse({
    required this.success,
    required this.personas,
  });

  /// FROM JSON
  factory PersonaResponse.fromJson(Map<String, dynamic> json) {
    return PersonaResponse(
      success: json['success'] ?? false,
      personas: (json['personas'] as List<dynamic>?)
          ?.map((e) => Persona.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'personas': personas.map((e) => e.toJson()).toList(),
    };
  }
}

class Persona {
  final String? profileType;
  final String? profileId;
  final String? profileName;
  final String? teamRole;
  final String? profileStatus;

  Persona({
    this.profileType,
    this.profileId,
    this.profileName,
    this.teamRole,
    this.profileStatus,
  });

  /// FROM JSON
  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      profileType: json['profileType'],
      profileId: json['profileId'],
      profileName: json['profileName'],
      teamRole: json['teamRole'],
      profileStatus: json['profileStatus'],
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      'profileType': profileType,
      'profileId': profileId,
      'profileName': profileName,
      'teamRole': teamRole,
      'profileStatus': profileStatus,
    };
  }
}
