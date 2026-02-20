class ConnectionsModel {
  final bool? success;
  final List<Connection>? connections;

  ConnectionsModel({
    this.success,
    this.connections,
  });

  factory ConnectionsModel.fromJson(Map<String, dynamic> json) {
    return ConnectionsModel(
      success: json['success'],
      connections: json['connections'] != null
          ? List<Connection>.from(
        json['connections'].map(
              (x) => Connection.fromJson(x),
        ),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'connections':
      connections?.map((x) => x.toJson()).toList(),
    };
  }
}

class Connection {
  final String? id;
  final String? connectorProfileId;
  final String? merchantProfileId;
  final String? requestedByProfileType;
  final String? requestedByProfileId;
  final String? requestedByUserId;
  final String? status;
  final String? requestedAt;
  final String? respondedAt;
  final String? respondedByUserId;
  final String? updatedAt;

  Connection({
    this.id,
    this.connectorProfileId,
    this.merchantProfileId,
    this.requestedByProfileType,
    this.requestedByProfileId,
    this.requestedByUserId,
    this.status,
    this.requestedAt,
    this.respondedAt,
    this.respondedByUserId,
    this.updatedAt,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['id'],
      connectorProfileId: json['connectorProfileId'],
      merchantProfileId: json['merchantProfileId'],
      requestedByProfileType: json['requestedByProfileType'],
      requestedByProfileId: json['requestedByProfileId'],
      requestedByUserId: json['requestedByUserId'],
      status: json['status'],
      requestedAt: json['requestedAt'],
      respondedAt: json['respondedAt'],
      respondedByUserId: json['respondedByUserId'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'connectorProfileId': connectorProfileId,
      'merchantProfileId': merchantProfileId,
      'requestedByProfileType': requestedByProfileType,
      'requestedByProfileId': requestedByProfileId,
      'requestedByUserId': requestedByUserId,
      'status': status,
      'requestedAt': requestedAt,
      'respondedAt': respondedAt,
      'respondedByUserId': respondedByUserId,
      'updatedAt': updatedAt,
    };
  }
}
