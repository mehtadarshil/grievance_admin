// To parse this JSON data, do
//
//     final alertDataModel = alertDataModelFromJson(jsonString);

import 'dart:convert';

AlertDataModel alertDataModelFromJson(String str) =>
    AlertDataModel.fromJson(json.decode(str));

String alertDataModelToJson(AlertDataModel data) => json.encode(data.toJson());

class AlertDataModel {
  final int? code;
  final bool? status;
  final Data? data;
  final DateTime? serverTime;

  AlertDataModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory AlertDataModel.fromJson(Map<String, dynamic> json) => AlertDataModel(
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
  final List<StatusNotification>? statusNotifications;
  final List<ResponseNotification>? responseNotifications;

  Data({
    this.statusNotifications,
    this.responseNotifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        statusNotifications: json["STATUS_NOTIFICATIONS"] == null
            ? []
            : List<StatusNotification>.from(json["STATUS_NOTIFICATIONS"]!
                .map((x) => StatusNotification.fromJson(x))),
        responseNotifications: json["RESPONSE_NOTIFICATIONS"] == null
            ? []
            : List<ResponseNotification>.from(json["RESPONSE_NOTIFICATIONS"]!
                .map((x) => ResponseNotification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "STATUS_NOTIFICATIONS": statusNotifications == null
            ? []
            : List<dynamic>.from(statusNotifications!.map((x) => x.toJson())),
        "RESPONSE_NOTIFICATIONS": responseNotifications == null
            ? []
            : List<dynamic>.from(responseNotifications!.map((x) => x.toJson())),
      };
}

class StatusNotification {
  final String? idStatusHistory;
  final String? createdBy;
  final DateTime? createdOn;
  final String? firstName;
  final String? lastName;
  final String? status;
  final String? requestId;
  final String? uniqueRequestId;
  final dynamic notification;
  final String? customerName;
  final String? updatedBy;
  final DateTime? updatedOn;

  StatusNotification({
    this.idStatusHistory,
    this.createdBy,
    this.createdOn,
    this.firstName,
    this.lastName,
    this.status,
    this.requestId,
    this.uniqueRequestId,
    this.notification,
    this.customerName,
    this.updatedBy,
    this.updatedOn,
  });

  factory StatusNotification.fromJson(Map<String, dynamic> json) =>
      StatusNotification(
        idStatusHistory: json["id_status_history"],
        createdBy: json["created_by"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        status: json["status"],
        requestId: json["request_id"],
        uniqueRequestId: json["unique_request_id"],
        notification: json["notification"],
        customerName: json["customer_name"],
        updatedBy: json["updated_by"],
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id_status_history": idStatusHistory,
        "created_by": createdBy,
        "created_on": createdOn?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "status": status,
        "request_id": requestId,
        "unique_request_id": uniqueRequestId,
        "notification": notification,
        "customer_name": customerName,
        "updated_by": updatedBy,
        "updated_on": updatedOn?.toIso8601String(),
      };
}

class ResponseNotification {
  final String? idEmailHistory;
  final String? createdBy;
  final String? subject;
  final String? emailStatusRemarks;
  final String? sendBy;
  final DateTime? createdOn;
  final dynamic firstName;
  final dynamic lastName;
  final String? customerFirstName;
  final String? customerLastName;
  final String? requestId;
  final String? uniqueRequestId;
  final String? updatedBy;
  final DateTime? updatedOn;

  ResponseNotification({
    this.idEmailHistory,
    this.createdBy,
    this.subject,
    this.emailStatusRemarks,
    this.sendBy,
    this.createdOn,
    this.firstName,
    this.lastName,
    this.customerFirstName,
    this.customerLastName,
    this.requestId,
    this.uniqueRequestId,
    this.updatedBy,
    this.updatedOn,
  });

  factory ResponseNotification.fromJson(Map<String, dynamic> json) =>
      ResponseNotification(
        idEmailHistory: json["id_email_history"],
        createdBy: json["created_by"],
        subject: json["subject"],
        emailStatusRemarks: json["email_status_remarks"],
        sendBy: json["send_by"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        customerFirstName: json["customer_first_name"],
        customerLastName: json["customer_last_name"],
        requestId: json["request_id"],
        uniqueRequestId: json["unique_request_id"],
        updatedBy: json["updated_by"],
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id_email_history": idEmailHistory,
        "created_by": createdBy,
        "subject": subject,
        "email_status_remarks": emailStatusRemarks,
        "send_by": sendBy,
        "created_on": createdOn?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "customer_first_name": customerFirstName,
        "customer_last_name": customerLastName,
        "request_id": requestId,
        "unique_request_id": uniqueRequestId,
        "updated_by": updatedBy,
        "updated_on": updatedOn?.toIso8601String(),
      };
}
