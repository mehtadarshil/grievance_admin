// To parse this JSON data, do
//
//     final statusHistoryModel = statusHistoryModelFromJson(jsonString);

import 'dart:convert';

StatusHistoryModel statusHistoryModelFromJson(String str) =>
    StatusHistoryModel.fromJson(json.decode(str));

String statusHistoryModelToJson(StatusHistoryModel data) =>
    json.encode(data.toJson());

class StatusHistoryModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  StatusHistoryModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory StatusHistoryModel.fromJson(Map<String, dynamic> json) =>
      StatusHistoryModel(
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
  final String? idStatusHistory;
  final String? requestStatus;
  final String? remarks;
  final String? requestStatusFile;
  final String? originalImagePath;
  final String? thumbImagePath;
  final String? isTransferred;
  final dynamic transferDate;
  final String? transferReason;
  final String? grievanceAssignedTo;
  final DateTime? grievanceAssignedDate;
  final String? grievanceAssignDetails;
  final String? grievanceReassignedTo;
  final dynamic grievanceReassignedDate;
  final String? grievanceReassignReason;
  final String? viewedUsers;
  final String? createdBy;
  final DateTime? createdOn;
  final String? status;
  final String? firstName;
  final String? lastName;
  final String? grievanceAssignedFirstname;
  final String? grievanceAssignedLastname;
  final dynamic grievanceReassignedFirstname;
  final dynamic grievanceReassignedLastname;
  final dynamic notification;

  Datum({
    this.idStatusHistory,
    this.requestStatus,
    this.remarks,
    this.requestStatusFile,
    this.originalImagePath,
    this.thumbImagePath,
    this.isTransferred,
    this.transferDate,
    this.transferReason,
    this.grievanceAssignedTo,
    this.grievanceAssignedDate,
    this.grievanceAssignDetails,
    this.grievanceReassignedTo,
    this.grievanceReassignedDate,
    this.grievanceReassignReason,
    this.viewedUsers,
    this.createdBy,
    this.createdOn,
    this.status,
    this.firstName,
    this.lastName,
    this.grievanceAssignedFirstname,
    this.grievanceAssignedLastname,
    this.grievanceReassignedFirstname,
    this.grievanceReassignedLastname,
    this.notification,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idStatusHistory: json["id_status_history"],
        requestStatus: json["request_status"],
        remarks: json["remarks"],
        requestStatusFile: json["request_status_file"],
        originalImagePath: json["original_image_path"],
        thumbImagePath: json["thumb_image_path"],
        isTransferred: json["is_transferred"],
        transferDate: json["transfer_date"],
        transferReason: json["transfer_reason"],
        grievanceAssignedTo: json["grievance_assigned_to"],
        grievanceAssignedDate: json["grievance_assigned_date"] == null
            ? null
            : DateTime.parse(json["grievance_assigned_date"]),
        grievanceAssignDetails: json["grievance_assign_details"],
        grievanceReassignedTo: json["grievance_reassigned_to"],
        grievanceReassignedDate: json["grievance_reassigned_date"],
        grievanceReassignReason: json["grievance_reassign_reason"],
        viewedUsers: json["viewed_users"],
        createdBy: json["created_by"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        grievanceAssignedFirstname: json["grievance_assigned_firstname"],
        grievanceAssignedLastname: json["grievance_assigned_lastname"],
        grievanceReassignedFirstname: json["grievance_reassigned_firstname"],
        grievanceReassignedLastname: json["grievance_reassigned_lastname"],
        notification: json["notification"],
      );

  Map<String, dynamic> toJson() => {
        "id_status_history": idStatusHistory,
        "request_status": requestStatus,
        "remarks": remarks,
        "request_status_file": requestStatusFile,
        "original_image_path": originalImagePath,
        "thumb_image_path": thumbImagePath,
        "is_transferred": isTransferred,
        "transfer_date": transferDate,
        "transfer_reason": transferReason,
        "grievance_assigned_to": grievanceAssignedTo,
        "grievance_assigned_date": grievanceAssignedDate?.toIso8601String(),
        "grievance_assign_details": grievanceAssignDetails,
        "grievance_reassigned_to": grievanceReassignedTo,
        "grievance_reassigned_date": grievanceReassignedDate,
        "grievance_reassign_reason": grievanceReassignReason,
        "viewed_users": viewedUsers,
        "created_by": createdBy,
        "created_on": createdOn?.toIso8601String(),
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "grievance_assigned_firstname": grievanceAssignedFirstname,
        "grievance_assigned_lastname": grievanceAssignedLastname,
        "grievance_reassigned_firstname": grievanceReassignedFirstname,
        "grievance_reassigned_lastname": grievanceReassignedLastname,
        "notification": notification,
      };
}
