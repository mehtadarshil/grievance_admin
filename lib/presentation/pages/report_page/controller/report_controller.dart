import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/app/models/filter_card_model.dart';
import 'package:grievance_admin/app/models/report_count_model.dart';
import 'package:grievance_admin/app/models/report_data_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';

class ReportController extends GetxController {
  final ApiClient _apiClient = Get.find();
  UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
  Rxn<ReportDataModel> reportData = Rxn<ReportDataModel>();
  Rxn<ReportCountModel> reportCount = Rxn<ReportCountModel>();

  RxBool isValid = false.obs;

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();

  RxString selectedFilterCard = "throughput".obs;
  RxString selectedDateType = "".obs;

  List<FilterCardModel> filterCardData = [
    FilterCardModel(title: "Grievance", value: "throughput"),
    FilterCardModel(title: "Resolved", value: "Resolved"),
    FilterCardModel(title: "Pending", value: "Pending"),
    FilterCardModel(
        title: "Transffered_Grievances", value: "Transffered Grievances"),
    FilterCardModel(title: "Immediate_Action", value: "Immediate Action"),
    FilterCardModel(title: "Medium_Term", value: "Medium Term"),
    FilterCardModel(title: "Long_Term", value: "Long Term")
  ];

  List<DropDownDataModel> dropdownData = [
    DropDownDataModel(text: "--- All ---", value: ""),
    DropDownDataModel(text: "Today", value: "today"),
    DropDownDataModel(text: "Last Week", value: "lw"),
    DropDownDataModel(text: "Current Month", value: "cm"),
    DropDownDataModel(text: "Last Month", value: "lm"),
    DropDownDataModel(text: "Last 3 Month", value: "l3m"),
    DropDownDataModel(text: "Last 6 Month", value: "l6m"),
    DropDownDataModel(text: "Last 9 Month", value: "l9m"),
    DropDownDataModel(text: "Date Range", value: "custom"),
  ];

  @override
  void onReady() {
    getReportData().then((value) {
      getReportCount();
    });
    super.onReady();
  }

  void isValidCheck() {
    if (selectedDateType.value == "custom" &&
        (fromDate.text.isEmpty || toDate.text.isEmpty)) {
      isValid(false);
    } else {
      isValid(true);
    }
  }

  Future getReportData() async {
    var reportDataJson =
        await _apiClient.post(path: ApiConst.wsGetGrievanceReportCount, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.adminType: userData.adminType,
      ApiConst.adminDepartment: userData.department,
      ApiConst.dateType: selectedDateType.value,
      ApiConst.dateFrom: fromDate.text,
      ApiConst.dateTo: toDate.text
    });
    if (reportDataJson != null) {
      ReportDataModel reportDataModel =
          ReportDataModel.fromJson(reportDataJson);
      if (reportDataModel.status ?? false) {
        reportData.value = reportDataModel;
      }
    }
  }

  Future getReportCount() async {
    var reportCountJson = await _apiClient
        .post(path: ApiConst.wsGetGrievanceReportNumbersForTabs, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.adminType: userData.adminType,
      ApiConst.adminDepartment: userData.department,
      ApiConst.dateType: selectedDateType.value,
      ApiConst.dateFrom: fromDate.text,
      ApiConst.dateTo: toDate.text
    });
    if (reportCountJson != null) {
      ReportCountModel reportCountModel =
          ReportCountModel.fromJson(reportCountJson);
      if (reportCountModel.status ?? false) {
        reportCount.value = reportCountModel;
      }
    }
  }
}
