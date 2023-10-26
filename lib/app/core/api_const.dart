class ApiConst {
  static const baseUrl =
      "https://home.arrowleaf.solutions/grievanceapi/adminweb/";
  static const apiKeyValue = "CODEX@123";
  static const wsCheckLogin = "adminapi/checklogin";
  static const wsGetGrievanceList = "request/getgrievancelist";
  static const wsRespondMailToUser = "request/respondmailtouser";
  static const wsGetEmailHistoryByGrievanceId =
      "request/getemailhistorybygrievanceid";
  static const wsGetAllStatus = "request/getallstatus";
  static const wsGetAdminUsersByType = "adminapi/getadminusersbytype";
  static const wstransferGrievance = "request/transfergrievance";
  static const wsUpdateGrievanceStatus = "request/updategrievancestatus";

  //const tags
  static const authorization = "Authorization";
  static const apiKey = "X-API-KEY";
  static const emailid = "emailid";
  static const password = "password";
  static const adminId = "admin_id";
  static const loggedinAdminId = "loggedin_admin_id";
  static const loggedinDepartmentId = "loggedin_department_id";
  static const grievanceId = "grievance_id";
  static const subject = "subject";
  static const message = "message";
  static const adminType = "admin_type";
  static const transferredToAdminUser = "transferredto_admin_user";
  static const transferReason = "transfer_reason";
  static const grievancePreviousStatus = "grievance_previous_status";
  static const grievanceStatus = "grievance_status";
  static const requestPreviousStatus = "request_previous_status";
  static const remarks = "remarks";
  static const grievanceStatusImage = "grievance_status_image";
}
