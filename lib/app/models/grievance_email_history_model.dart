// To parse this JSON data, do
//
//     final grievenceEmailHistoryModel = grievenceEmailHistoryModelFromJson(jsonString);

import 'dart:convert';

GrievenceEmailHistoryModel grievenceEmailHistoryModelFromJson(String str) =>
    GrievenceEmailHistoryModel.fromJson(json.decode(str));

String grievenceEmailHistoryModelToJson(GrievenceEmailHistoryModel data) =>
    json.encode(data.toJson());

class GrievenceEmailHistoryModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  GrievenceEmailHistoryModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory GrievenceEmailHistoryModel.fromJson(Map<String, dynamic> json) =>
      GrievenceEmailHistoryModel(
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
  final String? idEmailHistory;
  final String? subject;
  final String? emailStatusRemarks;
  final String? createdBy;
  final String? sendBy;
  final DateTime? createdOn;
  final String? firstName;
  final String? lastName;
  final String? customerFirstName;
  final String? customerLastName;

  Datum({
    this.idEmailHistory,
    this.subject,
    this.emailStatusRemarks,
    this.createdBy,
    this.sendBy,
    this.createdOn,
    this.firstName,
    this.lastName,
    this.customerFirstName,
    this.customerLastName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idEmailHistory: json["id_email_history"],
        subject: json["subject"],
        emailStatusRemarks: json["email_status_remarks"],
        createdBy: json["created_by"],
        sendBy: json["send_by"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        customerFirstName: json["customer_first_name"],
        customerLastName: json["customer_last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id_email_history": idEmailHistory,
        "subject": subject,
        "email_status_remarks": emailStatusRemarks,
        "created_by": createdBy,
        "send_by": sendBy,
        "created_on": createdOn?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "customer_first_name": customerFirstName,
        "customer_last_name": customerLastName,
      };
}
