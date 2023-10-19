// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

GrievenceListModel temperaturesFromJson(String str) =>
    GrievenceListModel.fromJson(json.decode(str));

String temperaturesToJson(GrievenceListModel data) =>
    json.encode(data.toJson());

class GrievenceListModel {
  final int? code;
  final bool? status;
  final List<Datum>? data;
  final DateTime? serverTime;

  GrievenceListModel({
    this.code,
    this.status,
    this.data,
    this.serverTime,
  });

  factory GrievenceListModel.fromJson(Map<String, dynamic> json) =>
      GrievenceListModel(
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
  final String? idRequest;
  final String? uniqueRequestId;
  final String? departmentIds;
  final String? requestInitiatedBy;
  final String? department;
  final String? requestPreviousStatus;
  final String? requestStatus;
  final String? requestFile;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final String? remarks;
  final String? requestDescription;
  final DateTime? updatedStatusDate;
  final String? assignedBy;
  final String? departmentNames;
  final String? customerName;
  final String? address;
  final String? grievanceAssignedTo;
  final DateTime? grievanceAssignedDate;
  final String? isTransferred;
  final DateTime? transferDate;
  final String? transferReason;
  final String? previousStatus;
  final String? previousStatusColor;
  final String? status;
  final String? totalMinutes;
  final String? statusColor;
  final String? firstName;
  final String? lastName;
  final String? transferredFirstName;
  final String? transferredLastName;
  final String? grievanceReassignedTo;
  final dynamic grievanceAssignedDepartment;
  final String? grievanceReassignReason;
  final String? latestresponsecreatedby;
  final String? totalunviewedemailstatus;
  final String? totalunviewedstatus;
  final List<LatestRequestEmailstatusArray>? latestRequestEmailstatusArray;
  final List<RequestEmailstatusArray>? requestEmailstatusArray;
  final List<RequestStatusArray>? requestStatusArray;
  final List<RequestFileArray>? requestFileArray;

  Datum({
    this.idRequest,
    this.uniqueRequestId,
    this.departmentIds,
    this.requestInitiatedBy,
    this.department,
    this.requestPreviousStatus,
    this.requestStatus,
    this.requestFile,
    this.createdOn,
    this.updatedOn,
    this.remarks,
    this.requestDescription,
    this.updatedStatusDate,
    this.assignedBy,
    this.departmentNames,
    this.customerName,
    this.address,
    this.grievanceAssignedTo,
    this.grievanceAssignedDate,
    this.isTransferred,
    this.transferDate,
    this.transferReason,
    this.previousStatus,
    this.previousStatusColor,
    this.status,
    this.totalMinutes,
    this.statusColor,
    this.firstName,
    this.lastName,
    this.transferredFirstName,
    this.transferredLastName,
    this.grievanceReassignedTo,
    this.grievanceAssignedDepartment,
    this.grievanceReassignReason,
    this.latestresponsecreatedby,
    this.totalunviewedemailstatus,
    this.totalunviewedstatus,
    this.latestRequestEmailstatusArray,
    this.requestEmailstatusArray,
    this.requestStatusArray,
    this.requestFileArray,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idRequest: json["id_request"],
        uniqueRequestId: json["unique_request_id"],
        departmentIds: json["department_ids"],
        requestInitiatedBy: json["request_initiated_by"],
        department: json["department"],
        requestPreviousStatus: json["request_previous_status"],
        requestStatus: json["request_status"],
        requestFile: json["request_file"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        remarks: json["remarks"],
        requestDescription: json["request_description"],
        updatedStatusDate: json["updated_status_date"] == null
            ? null
            : DateTime.parse(json["updated_status_date"]),
        assignedBy: json["assigned_by"],
        departmentNames: json["department_names"],
        customerName: json["customer_name"],
        address: json["address"],
        grievanceAssignedTo: json["grievance_assigned_to"],
        grievanceAssignedDate: json["grievance_assigned_date"] == null
            ? null
            : DateTime.parse(json["grievance_assigned_date"]),
        isTransferred: json["is_transferred"],
        transferDate: json["transfer_date"] == null
            ? null
            : DateTime.parse(json["transfer_date"]),
        transferReason: json["transfer_reason"],
        previousStatus: json["previous_status"],
        previousStatusColor: json["previous_status_color"],
        status: json["status"],
        totalMinutes: json["total_minutes"],
        statusColor: json["status_color"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        transferredFirstName: json["transferred_first_name"],
        transferredLastName: json["transferred_last_name"],
        grievanceReassignedTo: json["grievance_reassigned_to"],
        grievanceAssignedDepartment: json["grievance_assigned_department"],
        grievanceReassignReason: json["grievance_reassign_reason"],
        latestresponsecreatedby: json["latestresponsecreatedby"],
        totalunviewedemailstatus: json["totalunviewedemailstatus"],
        totalunviewedstatus: json["totalunviewedstatus"],
        latestRequestEmailstatusArray:
            json["latest_request_emailstatus_array"] == null
                ? []
                : List<LatestRequestEmailstatusArray>.from(
                    json["latest_request_emailstatus_array"]!
                        .map((x) => LatestRequestEmailstatusArray.fromJson(x))),
        requestEmailstatusArray: json["request_emailstatus_array"] == null
            ? []
            : List<RequestEmailstatusArray>.from(
                json["request_emailstatus_array"]!
                    .map((x) => RequestEmailstatusArray.fromJson(x))),
        requestStatusArray: json["request_status_array"] == null
            ? []
            : List<RequestStatusArray>.from(json["request_status_array"]!
                .map((x) => RequestStatusArray.fromJson(x))),
        requestFileArray: json["request_file_array"] == null
            ? []
            : List<RequestFileArray>.from(json["request_file_array"]!
                .map((x) => RequestFileArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_request": idRequest,
        "unique_request_id": uniqueRequestId,
        "department_ids": departmentIds,
        "request_initiated_by": requestInitiatedBy,
        "department": department,
        "request_previous_status": requestPreviousStatus,
        "request_status": requestStatus,
        "request_file": requestFile,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "remarks": remarks,
        "request_description": requestDescription,
        "updated_status_date": updatedStatusDate?.toIso8601String(),
        "assigned_by": assignedBy,
        "department_names": departmentNames,
        "customer_name": customerName,
        "address": address,
        "grievance_assigned_to": grievanceAssignedTo,
        "grievance_assigned_date": grievanceAssignedDate?.toIso8601String(),
        "is_transferred": isTransferred,
        "transfer_date": transferDate?.toIso8601String(),
        "transfer_reason": transferReason,
        "previous_status": previousStatus,
        "previous_status_color": previousStatusColor,
        "status": status,
        "total_minutes": totalMinutes,
        "status_color": statusColor,
        "first_name": firstName,
        "last_name": lastName,
        "transferred_first_name": transferredFirstName,
        "transferred_last_name": transferredLastName,
        "grievance_reassigned_to": grievanceReassignedTo,
        "grievance_assigned_department": grievanceAssignedDepartment,
        "grievance_reassign_reason": grievanceReassignReason,
        "latestresponsecreatedby": latestresponsecreatedby,
        "totalunviewedemailstatus": totalunviewedemailstatus,
        "totalunviewedstatus": totalunviewedstatus,
        "latest_request_emailstatus_array":
            latestRequestEmailstatusArray == null
                ? []
                : List<dynamic>.from(
                    latestRequestEmailstatusArray!.map((x) => x.toJson())),
        "request_emailstatus_array": requestEmailstatusArray == null
            ? []
            : List<dynamic>.from(
                requestEmailstatusArray!.map((x) => x.toJson())),
        "request_status_array": requestStatusArray == null
            ? []
            : List<dynamic>.from(requestStatusArray!.map((x) => x.toJson())),
        "request_file_array": requestFileArray == null
            ? []
            : List<dynamic>.from(requestFileArray!.map((x) => x.toJson())),
      };
}

class RequestStatusArray {
  final String? idStatusHistory;
  final String? requestStatus;
  final String? remarks;
  final String? viewedUsers;
  final String? isTransferred;
  final String? transferredTo;
  final dynamic transferDate;
  final String? transferReason;
  final String? grievanceAssignedTo;
  final dynamic grievanceAssignedDate;
  final String? requestStatusFile;
  final String? originalImagePath;
  final String? thumbImagePath;
  final String? grievanceAssignDetails;
  final String? grievanceReassignedTo;
  final dynamic grievanceReassignedDate;
  final String? grievanceReassignReason;
  final String? createdBy;
  final dynamic transferredtoFirstname;
  final dynamic transferredtoLastname;
  final dynamic grievanceAssignedFirstname;
  final dynamic grievanceAssignedLastname;
  final dynamic departmentName;
  final DateTime? createdOn;
  final String? status;

  RequestStatusArray({
    this.idStatusHistory,
    this.requestStatus,
    this.remarks,
    this.viewedUsers,
    this.isTransferred,
    this.transferredTo,
    this.transferDate,
    this.transferReason,
    this.grievanceAssignedTo,
    this.grievanceAssignedDate,
    this.requestStatusFile,
    this.originalImagePath,
    this.thumbImagePath,
    this.grievanceAssignDetails,
    this.grievanceReassignedTo,
    this.grievanceReassignedDate,
    this.grievanceReassignReason,
    this.createdBy,
    this.transferredtoFirstname,
    this.transferredtoLastname,
    this.grievanceAssignedFirstname,
    this.grievanceAssignedLastname,
    this.departmentName,
    this.createdOn,
    this.status,
  });

  factory RequestStatusArray.fromJson(Map<String, dynamic> json) =>
      RequestStatusArray(
        idStatusHistory: json["id_status_history"],
        requestStatus: json["request_status"],
        remarks: json["remarks"],
        viewedUsers: json["viewed_users"],
        isTransferred: json["is_transferred"],
        transferredTo: json["transferred_to"],
        transferDate: json["transfer_date"],
        transferReason: json["transfer_reason"],
        grievanceAssignedTo: json["grievance_assigned_to"],
        grievanceAssignedDate: json["grievance_assigned_date"],
        requestStatusFile: json["request_status_file"],
        originalImagePath: json["original_image_path"],
        thumbImagePath: json["thumb_image_path"],
        grievanceAssignDetails: json["grievance_assign_details"],
        grievanceReassignedTo: json["grievance_reassigned_to"],
        grievanceReassignedDate: json["grievance_reassigned_date"],
        grievanceReassignReason: json["grievance_reassign_reason"],
        createdBy: json["created_by"],
        transferredtoFirstname: json["transferredto_firstname"],
        transferredtoLastname: json["transferredto_lastname"],
        grievanceAssignedFirstname: json["grievance_assigned_firstname"],
        grievanceAssignedLastname: json["grievance_assigned_lastname"],
        departmentName: json["department_name"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_status_history": idStatusHistory,
        "request_status": requestStatus,
        "remarks": remarks,
        "viewed_users": viewedUsers,
        "is_transferred": isTransferred,
        "transferred_to": transferredTo,
        "transfer_date": transferDate,
        "transfer_reason": transferReason,
        "grievance_assigned_to": grievanceAssignedTo,
        "grievance_assigned_date": grievanceAssignedDate,
        "request_status_file": requestStatusFile,
        "original_image_path": originalImagePath,
        "thumb_image_path": thumbImagePath,
        "grievance_assign_details": grievanceAssignDetails,
        "grievance_reassigned_to": grievanceReassignedTo,
        "grievance_reassigned_date": grievanceReassignedDate,
        "grievance_reassign_reason": grievanceReassignReason,
        "created_by": createdBy,
        "transferredto_firstname": transferredtoFirstname,
        "transferredto_lastname": transferredtoLastname,
        "grievance_assigned_firstname": grievanceAssignedFirstname,
        "grievance_assigned_lastname": grievanceAssignedLastname,
        "department_name": departmentName,
        "created_on": createdOn?.toIso8601String(),
        "status": status,
      };
}

class LatestRequestEmailstatusArray {
  final String? idEmailHistory;
  final String? emailRespondStatus;
  final DateTime? createdOn;

  LatestRequestEmailstatusArray({
    this.idEmailHistory,
    this.emailRespondStatus,
    this.createdOn,
  });

  factory LatestRequestEmailstatusArray.fromJson(Map<String, dynamic> json) =>
      LatestRequestEmailstatusArray(
        idEmailHistory: json["id_email_history"],
        emailRespondStatus: json["email_respond_status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id_email_history": idEmailHistory,
        "email_respond_status": emailRespondStatus,
        "created_on": createdOn?.toIso8601String(),
      };
}

class RequestEmailstatusArray {
  final String? idEmailHistory;
  final String? subject;
  final String? emailStatusRemarks;
  final String? isViewed;
  final String? viewedUsers;
  final String? fromUser;
  final String? toUser;
  final String? sendBy;
  final String? createdBy;
  final DateTime? createdOn;
  final String? firstName;
  final String? lastName;
  final String? customerFirstName;
  final String? customerLastName;

  RequestEmailstatusArray({
    this.idEmailHistory,
    this.subject,
    this.emailStatusRemarks,
    this.isViewed,
    this.viewedUsers,
    this.fromUser,
    this.toUser,
    this.sendBy,
    this.createdBy,
    this.createdOn,
    this.firstName,
    this.lastName,
    this.customerFirstName,
    this.customerLastName,
  });

  factory RequestEmailstatusArray.fromJson(Map<String, dynamic> json) =>
      RequestEmailstatusArray(
        idEmailHistory: json["id_email_history"],
        subject: json["subject"],
        emailStatusRemarks: json["email_status_remarks"],
        isViewed: json["is_viewed"],
        viewedUsers: json["viewed_users"],
        fromUser: json["from_user"],
        toUser: json["to_user"],
        sendBy: json["send_by"],
        createdBy: json["created_by"],
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
        "is_viewed": isViewed,
        "viewed_users": viewedUsers,
        "from_user": fromUser,
        "to_user": toUser,
        "send_by": sendBy,
        "created_by": createdBy,
        "created_on": createdOn?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "customer_first_name": customerFirstName,
        "customer_last_name": customerLastName,
      };
}

class RequestFileArray {
  final String? requestImageId;
  final String? requestImageName;
  final String? requestImagePath;

  RequestFileArray({
    this.requestImageId,
    this.requestImageName,
    this.requestImagePath,
  });

  factory RequestFileArray.fromJson(Map<String, dynamic> json) =>
      RequestFileArray(
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
