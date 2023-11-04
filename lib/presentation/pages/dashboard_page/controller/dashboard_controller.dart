import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/department_graph_data_model.dart';
import 'package:grievance_admin/app/models/department_model.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/app/models/get_all_status_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/models/status_graph_data_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiClient _apiClient = Get.find();

  List<DropDownDataModel> dropdownData = [
    DropDownDataModel(text: "Today", value: "today"),
    DropDownDataModel(text: "Last Week", value: "lw"),
    DropDownDataModel(text: "Current Month", value: "cm"),
    DropDownDataModel(text: "Last Month", value: "lm"),
    DropDownDataModel(text: "Last 3 Month", value: "l3m"),
    DropDownDataModel(text: "Last 6 Month", value: "l6m"),
    DropDownDataModel(text: "Last 9 Month", value: "l9m"),
    DropDownDataModel(text: "Date Range", value: "custom"),
  ];

  RxBool isValidStatus = true.obs;
  RxString selectedDateTypeStatus = "cm".obs;
  RxSet<String> selectedDepartmentIds = <String>{}.obs;
  RxSet<String> selectedStatusIds = <String>{}.obs;
  Rxn<DepartmentModel> departmentModel = Rxn<DepartmentModel>();
  Rxn<GetAllStatusModel> allStatusModel = Rxn<GetAllStatusModel>();

  void isValidCheck() {
    if (selectedDateTypeStatus.value == "custom" &&
        (fromDateStatus.text.isEmpty || toDateStatus.text.isEmpty)) {
      isValidStatus(false);
    } else {
      isValidStatus(true);
    }
  }

  void isValidCheck2() {
    if (selectedDateTypeDepartment.value == "custom" &&
        (fromDateDepartment.text.isEmpty || toDateDepartment.text.isEmpty)) {
      isValidDepartment(false);
    } else {
      isValidDepartment(true);
    }
  }

  Rxn<StatusGraphDataModel> statusGraphDataModel = Rxn<StatusGraphDataModel>();
  final TextEditingController departmentStatus = TextEditingController();
  final TextEditingController statusStatus = TextEditingController();
  final TextEditingController fromDateStatus = TextEditingController();
  final TextEditingController toDateStatus = TextEditingController();

  RxBool isValidDepartment = true.obs;
  RxString selectedDateTypeDepartment = "cm".obs;
  RxSet<String> selectedDepartmentIdsDepartment = <String>{}.obs;
  RxSet<String> selectedStatusIdsDepartment = <String>{}.obs;
  Rxn<DepartmentGraphDataModel> departmentGraphDataModel =
      Rxn<DepartmentGraphDataModel>();
  final TextEditingController departmentDepartment = TextEditingController();
  final TextEditingController statusDepartment = TextEditingController();
  final TextEditingController fromDateDepartment = TextEditingController();
  final TextEditingController toDateDepartment = TextEditingController();

  @override
  void onReady() {
    getStatusGraphData().then((value) async {
      await getDepartmentGraphData();
      await getDepartments();
      await getAllStatus();
    });
    super.onReady();
  }

  late final TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  Future<void> getDepartments() async {
    var departJson = await _apiClient.get(path: ApiConst.wsGetAllDepartments);
    if (departJson != null) {
      departmentModel.value = DepartmentModel.fromJson(departJson);
    }
  }

  Future<void> getAllStatus() async {
    var allStatusJson = await _apiClient.get(path: ApiConst.wsGetAllStatus);
    if (allStatusJson != null) {
      var getAllStatusModel = GetAllStatusModel.fromJson(allStatusJson);
      if (getAllStatusModel.status! && getAllStatusModel.data!.isNotEmpty) {
        allStatusModel.value = getAllStatusModel;
      }
    }
  }

  Future<void> getStatusGraphData() async {
    String departmentIds = "";
    if (selectedDepartmentIds.isNotEmpty) {
      for (var element in selectedDepartmentIds) {
        departmentIds += "$element,";
      }
    }
    String stausIds = "";
    if (selectedStatusIds.isNotEmpty) {
      for (var element in selectedStatusIds) {
        stausIds += "$element,";
      }
    }
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var statusGraphDataJson = await _apiClient
        .post(path: ApiConst.wsGetGrievanceStatusWiseGraph, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.adminType: userData.adminType,
      ApiConst.dateType: selectedDateTypeStatus.value,
      ApiConst.dateFrom: fromDateStatus.text,
      ApiConst.dateTo: toDateStatus.text,
      ApiConst.departmentIds: departmentIds,
      ApiConst.grievanceStatus: stausIds
    });

    if (statusGraphDataJson != null) {
      StatusGraphDataModel statusGraphModel =
          StatusGraphDataModel.fromJson(statusGraphDataJson);
      if (statusGraphModel.status ?? false) {
        statusGraphDataModel.value = statusGraphModel;
      } else {
        statusGraphDataModel.value = null;
      }
    }
  }

  Future<void> getDepartmentGraphData() async {
    String departmentIds = "";
    if (selectedDepartmentIdsDepartment.isNotEmpty) {
      for (var element in selectedDepartmentIdsDepartment) {
        departmentIds += "$element,";
      }
    }
    String stausIds = "";
    if (selectedStatusIdsDepartment.isNotEmpty) {
      for (var element in selectedStatusIdsDepartment) {
        stausIds += "$element,";
      }
    }
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var departmentGraphDataJson = await _apiClient
        .post(path: ApiConst.wsGetGrievanceDepartmentWiseGraph, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.adminType: userData.adminType,
      ApiConst.dateType: selectedDateTypeDepartment.value,
      ApiConst.dateFrom: fromDateDepartment.text,
      ApiConst.dateTo: toDateDepartment.text,
      ApiConst.departmentIds: departmentIds,
      ApiConst.grievanceStatus: stausIds
    });

    if (departmentGraphDataJson != null) {
      DepartmentGraphDataModel departmentGraphModel =
          DepartmentGraphDataModel.fromJson(departmentGraphDataJson);
      if (departmentGraphModel.status ?? false) {
        departmentGraphDataModel.value = departmentGraphModel;
      } else {
        departmentGraphDataModel.value = null;
      }
    }
  }
}
