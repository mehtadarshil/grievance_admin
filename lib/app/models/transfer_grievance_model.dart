// To parse this JSON data, do
//
//     final transferGrievanceModel = transferGrievanceModelFromJson(jsonString);

import 'dart:convert';

TransferGrievanceModel transferGrievanceModelFromJson(String str) =>
    TransferGrievanceModel.fromJson(json.decode(str));

String transferGrievanceModelToJson(TransferGrievanceModel data) =>
    json.encode(data.toJson());

class TransferGrievanceModel {
  final int? code;
  final bool? status;
  final Data? data;
  final String? message;
  final DateTime? serverTime;

  TransferGrievanceModel({
    this.code,
    this.status,
    this.data,
    this.message,
    this.serverTime,
  });

  factory TransferGrievanceModel.fromJson(Map<String, dynamic> json) =>
      TransferGrievanceModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        serverTime: json["server_time"] == null
            ? null
            : DateTime.parse(json["server_time"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "server_time": serverTime?.toIso8601String(),
      };
}

class Data {
  final String? message;

  Data({
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
