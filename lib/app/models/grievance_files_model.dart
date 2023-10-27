// To parse this JSON data, do
//
//     final grievanceFilesModel = grievanceFilesModelFromJson(jsonString);

import 'dart:convert';

GrievanceFilesModel grievanceFilesModelFromJson(String str) =>
    GrievanceFilesModel.fromJson(json.decode(str));

String grievanceFilesModelToJson(GrievanceFilesModel data) =>
    json.encode(data.toJson());

class GrievanceFilesModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  GrievanceFilesModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory GrievanceFilesModel.fromJson(Map<String, dynamic> json) =>
      GrievanceFilesModel(
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
  final String? requestImageId;
  final String? requestImageName;
  final String? requestImagePath;

  Datum({
    this.requestImageId,
    this.requestImageName,
    this.requestImagePath,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        requestImageId: json["request_image_id"],
        requestImageName: json["request_image_name"],
        requestImagePath: json["request_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "request_image_id": requestImageId,
        "request_image_name": requestImageName,
        "request_image_path": requestImagePath,
      };
}
