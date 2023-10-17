// To parse this JSON data, do
//
//     final signinModel = signinModelFromJson(jsonString);

import 'dart:convert';

SigninModel signinModelFromJson(String str) =>
    SigninModel.fromJson(json.decode(str));

String signinModelToJson(SigninModel data) => json.encode(data.toJson());

class SigninModel {
  final int? code;
  final bool? status;
  final List<UserData>? data;
  final String? message;
  final DateTime? serverTime;

  SigninModel({
    this.code,
    this.status,
    this.data,
    this.message,
    this.serverTime,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) => SigninModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserData>.from(
                json["data"]!.map((x) => UserData.fromJson(x))),
        serverTime: json["server_time"] == null
            ? null
            : DateTime.parse(json["server_time"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "server_time": serverTime?.toIso8601String(),
      };
}

class UserData {
  final String? idAdmin;
  final String? firstName;
  final String? lastName;
  final String? emailId;
  final String? address;
  final String? adminType;
  final String? role;
  final String? department;

  UserData({
    this.idAdmin,
    this.firstName,
    this.lastName,
    this.emailId,
    this.address,
    this.adminType,
    this.role,
    this.department,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        idAdmin: json["id_admin"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailId: json["email_id"],
        address: json["address"],
        adminType: json["admin_type"],
        role: json["role"],
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "id_admin": idAdmin,
        "first_name": firstName,
        "last_name": lastName,
        "email_id": emailId,
        "address": address,
        "admin_type": adminType,
        "role": role,
        "department": department,
      };
}
