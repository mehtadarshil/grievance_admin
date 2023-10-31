// To parse this JSON data, do
//
//     final reportCountModel = reportCountModelFromJson(jsonString);

import 'dart:convert';

ReportCountModel reportCountModelFromJson(String str) =>
    ReportCountModel.fromJson(json.decode(str));

String reportCountModelToJson(ReportCountModel data) =>
    json.encode(data.toJson());

class ReportCountModel {
  final int? code;
  final bool? status;
  final Data? data;
  final DateTime? serverTime;

  ReportCountModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory ReportCountModel.fromJson(Map<String, dynamic> json) =>
      ReportCountModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        serverTime: json["server_time"] == null
            ? null
            : DateTime.parse(json["server_time"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
        "server_time": serverTime?.toIso8601String(),
      };
}

class Data {
  final int? totalGrievances;
  final int? resolvedGrievances;
  final int? pendingGrievances;
  final int? transferredGrievances;
  final int? immediateGrievances;
  final int? mediumTermGrievances;
  final int? longTermGrievances;

  Data({
    this.totalGrievances,
    this.resolvedGrievances,
    this.pendingGrievances,
    this.transferredGrievances,
    this.immediateGrievances,
    this.mediumTermGrievances,
    this.longTermGrievances,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalGrievances: json["TotalGrievances"],
        resolvedGrievances: json["ResolvedGrievances"],
        pendingGrievances: json["PendingGrievances"],
        transferredGrievances: json["TransferredGrievances"],
        immediateGrievances: json["ImmediateGrievances"],
        mediumTermGrievances: json["MediumTermGrievances"],
        longTermGrievances: json["LongTermGrievances"],
      );

  Map<String, dynamic> toJson() => {
        "TotalGrievances": totalGrievances,
        "ResolvedGrievances": resolvedGrievances,
        "PendingGrievances": pendingGrievances,
        "TransferredGrievances": transferredGrievances,
        "ImmediateGrievances": immediateGrievances,
        "MediumTermGrievances": mediumTermGrievances,
        "LongTermGrievances": longTermGrievances,
      };
}
