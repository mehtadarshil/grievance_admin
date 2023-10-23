// To parse this JSON data, do
//
//     final getAllStatusModel = getAllStatusModelFromJson(jsonString);

import 'dart:convert';

GetAllStatusModel getAllStatusModelFromJson(String str) =>
    GetAllStatusModel.fromJson(json.decode(str));

String getAllStatusModelToJson(GetAllStatusModel data) =>
    json.encode(data.toJson());

class GetAllStatusModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  GetAllStatusModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory GetAllStatusModel.fromJson(Map<String, dynamic> json) =>
      GetAllStatusModel(
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
  final String? idStatus;
  final String? status;
  final String? isDefault;
  final DateTime? createdOn;

  Datum({
    this.idStatus,
    this.status,
    this.isDefault,
    this.createdOn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idStatus: json["id_status"],
        status: json["status"],
        isDefault: json["is_default"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id_status": idStatus,
        "status": status,
        "is_default": isDefault,
        "created_on": createdOn?.toIso8601String(),
      };
}
