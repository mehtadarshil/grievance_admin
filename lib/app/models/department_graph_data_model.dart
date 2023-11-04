// To parse this JSON data, do
//
//     final departmentGraphDataModel = departmentGraphDataModelFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

DepartmentGraphDataModel departmentGraphDataModelFromJson(String str) =>
    DepartmentGraphDataModel.fromJson(json.decode(str));

String departmentGraphDataModelToJson(DepartmentGraphDataModel data) =>
    json.encode(data.toJson());

class DepartmentGraphDataModel {
  final int? code;
  final bool? status;
  final List<DepartmentDatum>? data;
  final DateTime? serverTime;

  DepartmentGraphDataModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory DepartmentGraphDataModel.fromJson(Map<String, dynamic> json) =>
      DepartmentGraphDataModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DepartmentDatum>.from(
                json["data"]!.map((x) => DepartmentDatum.fromJson(x))),
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

class DepartmentDatum {
  final String? idDepartment;
  final String? departmentName;
  final String? totalRequests;
  final Color? color;

  DepartmentDatum(
      {this.idDepartment, this.departmentName, this.totalRequests, this.color});

  factory DepartmentDatum.fromJson(Map<String, dynamic> json) =>
      DepartmentDatum(
          idDepartment: json["id_department"],
          departmentName: json["department_name"],
          totalRequests: json["total_requests"],
          color: Color((Random().nextDouble() * 0xFFFFFF).toInt()));

  Map<String, dynamic> toJson() => {
        "id_department": idDepartment,
        "department_name": departmentName,
        "total_requests": totalRequests,
      };
}
