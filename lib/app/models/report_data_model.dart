// To parse this JSON data, do
//
//     final reportDataModel = reportDataModelFromJson(jsonString);

import 'dart:convert';

ReportDataModel reportDataModelFromJson(String str) =>
    ReportDataModel.fromJson(json.decode(str));

String reportDataModelToJson(ReportDataModel data) =>
    json.encode(data.toJson());

class ReportDataModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  ReportDataModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory ReportDataModel.fromJson(Map<String, dynamic> json) =>
      ReportDataModel(
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
  final String? totalGrievances;
  final String? totalResolved;
  final String? totalPending;
  final String? totalImmediateAction;
  final String? totalMediumTerm;
  final String? totalLongTerm;
  final String? totalTransferred;
  final String? totalNotResponded;

  Datum({
    this.idDepartment,
    this.departmentName,
    this.totalGrievances,
    this.totalResolved,
    this.totalPending,
    this.totalImmediateAction,
    this.totalMediumTerm,
    this.totalLongTerm,
    this.totalTransferred,
    this.totalNotResponded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idDepartment: json["id_department"],
        departmentName: json["department_name"],
        totalGrievances: json["total_grievances"],
        totalResolved: json["total_resolved"],
        totalPending: json["total_pending"],
        totalImmediateAction: json["total_immediate_action"],
        totalMediumTerm: json["total_medium_term"],
        totalLongTerm: json["total_long_term"],
        totalTransferred: json["total_transferred"],
        totalNotResponded: json["total_not_responded"],
      );

  Map<String, dynamic> toJson() => {
        "id_department": idDepartment,
        "department_name": departmentName,
        "total_grievances": totalGrievances,
        "total_resolved": totalResolved,
        "total_pending": totalPending,
        "total_immediate_action": totalImmediateAction,
        "total_medium_term": totalMediumTerm,
        "total_long_term": totalLongTerm,
        "total_transferred": totalTransferred,
        "total_not_responded": totalNotResponded,
      };
}
