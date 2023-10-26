// To parse this JSON data, do
//
//     final adminUsersModel = adminUsersModelFromJson(jsonString);

import 'dart:convert';

AdminUsersModel adminUsersModelFromJson(String str) =>
    AdminUsersModel.fromJson(json.decode(str));

String adminUsersModelToJson(AdminUsersModel data) =>
    json.encode(data.toJson());

class AdminUsersModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  AdminUsersModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory AdminUsersModel.fromJson(Map<String, dynamic> json) =>
      AdminUsersModel(
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
  final String? idAdmin;
  final String? firstName;
  final String? lastName;

  Datum({
    this.idAdmin,
    this.firstName,
    this.lastName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAdmin: json["id_admin"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id_admin": idAdmin,
        "first_name": firstName,
        "last_name": lastName,
      };
}
