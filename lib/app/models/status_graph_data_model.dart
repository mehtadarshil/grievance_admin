// To parse this JSON data, do
//
//     final statusGraphDataModel = statusGraphDataModelFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

StatusGraphDataModel statusGraphDataModelFromJson(String str) =>
    StatusGraphDataModel.fromJson(json.decode(str));

String statusGraphDataModelToJson(StatusGraphDataModel data) =>
    json.encode(data.toJson());

class StatusGraphDataModel {
  final int? code;
  final bool? status;
  final List<DatumGraph>? data;
  final DateTime? serverTime;

  StatusGraphDataModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory StatusGraphDataModel.fromJson(Map<String, dynamic> json) =>
      StatusGraphDataModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DatumGraph>.from(
                json["data"]!.map((x) => DatumGraph.fromJson(x))),
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

class DatumGraph {
  final String? idStatus;
  final String? statusName;
  final String? totalRequests;
  final Color? color;

  DatumGraph({this.idStatus, this.statusName, this.totalRequests, this.color});

  factory DatumGraph.fromJson(Map<String, dynamic> json) => DatumGraph(
      idStatus: json["id_status"],
      statusName: json["status_name"],
      totalRequests: json["total_requests"],
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()));

  Map<String, dynamic> toJson() => {
        "id_status": idStatus,
        "status_name": statusName,
        "total_requests": totalRequests,
      };
}
