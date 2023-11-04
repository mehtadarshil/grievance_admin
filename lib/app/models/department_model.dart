// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

DepartmentModel departmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(DepartmentModel data) =>
    json.encode(data.toJson());

class DepartmentModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  DepartmentModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
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
  final String? idDepartment;
  final String? departmentName;
  final String? isDefault;
  final DateTime? createdOn;

  Datum({
    this.idDepartment,
    this.departmentName,
    this.isDefault,
    this.createdOn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idDepartment: json["id_department"],
        departmentName: json["department_name"],
        isDefault: json["is_default"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id_department": idDepartment,
        "department_name": departmentName,
        "is_default": isDefault,
        "created_on": createdOn?.toIso8601String(),
      };
}
