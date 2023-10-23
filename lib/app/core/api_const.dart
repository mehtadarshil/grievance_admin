class ApiConst {
  static const baseUrl =
      "https://home.arrowleaf.solutions/grievanceapi/adminweb/";
  static const apiKeyValue = "CODEX@123";
  static const wsCheckLogin = "adminapi/checklogin";
  static const wsGetGrievanceList = "request/getgrievancelist";
  static const wsRespondMailToUser = "request/respondmailtouser";
  static const wsGetEmailHistoryByGrievanceId =
      "request/getemailhistorybygrievanceid";

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
}
