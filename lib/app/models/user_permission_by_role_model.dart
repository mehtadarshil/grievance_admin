// To parse this JSON data, do
//
//     final userPermissionByRoleModel = userPermissionByRoleModelFromJson(jsonString);

import 'dart:convert';

UserPermissionByRoleModel userPermissionByRoleModelFromJson(String str) =>
    UserPermissionByRoleModel.fromJson(json.decode(str));

String userPermissionByRoleModelToJson(UserPermissionByRoleModel data) =>
    json.encode(data.toJson());

class UserPermissionByRoleModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  UserPermissionByRoleModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory UserPermissionByRoleModel.fromJson(Map<String, dynamic> json) =>
      UserPermissionByRoleModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        serverTime: json["server_time"] == null
            ? null
            : DateTime.parse(json["server_time"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "server_time": serverTime?.toIso8601String(),
      };
}

class Datum {
  final String? permissionId;
  final String? permissionGroupId;
  final String? permissionName;
  final String? accessMode;

  Datum({
    this.permissionId,
    this.permissionGroupId,
    this.permissionName,
    this.accessMode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        permissionId: json["permission_id"],
        permissionGroupId: json["permission_group_id"],
        permissionName: json["permission_name"],
        accessMode: json["access_mode"],
      );

  Map<String, dynamic> toJson() => {
        "permission_id": permissionId,
        "permission_group_id": permissionGroupId,
        "permission_name": permissionName,
        "access_mode": accessMode,
      };
}
