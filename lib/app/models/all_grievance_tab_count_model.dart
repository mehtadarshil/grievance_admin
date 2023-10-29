// To parse this JSON data, do
//
//     final allGrievanceTabCountModel = allGrievanceTabCountModelFromJson(jsonString);

import 'dart:convert';

AllGrievanceTabCountModel allGrievanceTabCountModelFromJson(String str) =>
    AllGrievanceTabCountModel.fromJson(json.decode(str));

String allGrievanceTabCountModelToJson(AllGrievanceTabCountModel data) =>
    json.encode(data.toJson());

class AllGrievanceTabCountModel {
  final int? code;
  final bool? status;
  final Data? data;
  final DateTime? serverTime;

  AllGrievanceTabCountModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory AllGrievanceTabCountModel.fromJson(Map<String, dynamic> json) =>
      AllGrievanceTabCountModel(
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
  final int? grievances;
  final int? unassignedGrievances;
  final int? communicatedGrievances;
  final int? unreadCommunicatedGrievances;
  final int? transferredGrievances;
  final int? closedResolvedGrievances;
  final int? grievancesInBucket;
  final int? pendencyGrievances;

  Data({
    this.grievances,
    this.unassignedGrievances,
    this.communicatedGrievances,
    this.unreadCommunicatedGrievances,
    this.transferredGrievances,
    this.closedResolvedGrievances,
    this.grievancesInBucket,
    this.pendencyGrievances,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        grievances: json["Grievances"],
        unassignedGrievances: json["UnassignedGrievances"],
        communicatedGrievances: json["CommunicatedGrievances"],
        unreadCommunicatedGrievances: json["UnreadCommunicatedGrievances"],
        transferredGrievances: json["TransferredGrievances"],
        closedResolvedGrievances: json["ClosedResolvedGrievances"],
        grievancesInBucket: json["GrievancesInBucket"],
        pendencyGrievances: json["PendencyGrievances"],
      );

  Map<String, dynamic> toJson() => {
        "Grievances": grievances,
        "UnassignedGrievances": unassignedGrievances,
        "CommunicatedGrievances": communicatedGrievances,
        "UnreadCommunicatedGrievances": unreadCommunicatedGrievances,
        "TransferredGrievances": transferredGrievances,
        "ClosedResolvedGrievances": closedResolvedGrievances,
        "GrievancesInBucket": grievancesInBucket,
        "PendencyGrievances": pendencyGrievances,
      };
}
