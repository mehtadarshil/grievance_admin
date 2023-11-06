import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/di/app_base_component.dart';
import 'package:grievance_admin/app/models/all_grievance_tab_count_model.dart';
import 'package:grievance_admin/app/models/department_model.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/app/models/filter_card_model.dart';
import 'package:grievance_admin/app/models/get_all_status_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/models/user_permission_by_role_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/logger.dart';

class GrievenceListController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController loactionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  RxList<GDatum> grievanceDetails = <GDatum>[].obs;
  final ApiClient _apiClient = Get.find();
  RxString selectedFilterCard = "throughput".obs;
  RxString selectedDateType = "".obs;
  RxList<DropDownDataModel> allStatus = <DropDownDataModel>[].obs;
  RxString selectedStatus = "".obs;
  List<String> permissions = [];
  Rxn<AllGrievanceTabCountModel> allTabCount = Rxn<AllGrievanceTabCountModel>();
  Rxn<DepartmentModel> departmentModel = Rxn<DepartmentModel>();
  RxString selectedDepartmentId = ''.obs;
  String tempDepartmentName = '';
  String tempDepartmentId = '';
  int pageNo = 1;

  RxBool isValid = true.obs;

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();

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

  void isValidCheck() {
    if (selectedDateType.value == "custom" &&
        (fromDate.text.isEmpty || toDate.text.isEmpty)) {
      isValid(false);
    } else {
      isValid(true);
    }
  }

  List<FilterCardModel> filterCardData = [
    FilterCardModel(title: "Grievance", value: "throughput"),
    FilterCardModel(title: "Pending", value: "pendency"),
    FilterCardModel(title: "Transferred", value: "transferred"),
    FilterCardModel(
        title: "Unassigned_Grievances", value: "unassignedgrievance"),
    FilterCardModel(title: "Resolved/Closed", value: "closedresolved")
  ];

  @override
  void onInit() {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
        } else {
          if (!AppComponentBase.instance.loading) {
            pageNo = (pageNo + 1);
            await getGrievanceList();
            await loadCount();
          }
        }
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    getGrievanceList().then((value) async {
      await loadCount();
      await getAllStatus();
      await loadPermissions();
      await getDepartments();
    });
    super.onReady();
  }

  Future<void> getDepartments() async {
    var departJson = await _apiClient.get(path: ApiConst.wsGetAllDepartments);
    if (departJson != null) {
      departmentModel.value = DepartmentModel.fromJson(departJson);
      selectedDepartmentId.value =
          departmentModel.value!.data!.first.idDepartment!;
      tempDepartmentId = departmentModel.value!.data!.first.idDepartment!;
      tempDepartmentName = departmentModel.value!.data!.first.departmentName!;
    }
  }

  Future<void> getGrievanceList() async {
    Logger.prints({
      ApiConst.adminId:
          UserData.fromJson(GetStorage().read(DbKeys.userData)).idAdmin,
      ApiConst.filterType: selectedFilterCard.value,
      ApiConst.grievanceStatusId: selectedStatus.value,
      ApiConst.customerName: customerController.text,
      ApiConst.address: loactionController.text,
      ApiConst.adminDepartment: tempDepartmentId,
      ApiConst.dateType: selectedDateType.value,
      ApiConst.dateFrom: fromDate.text,
      ApiConst.dateTo: toDate.text,
      ApiConst.noOfRequestsPerPage: "20",
      ApiConst.pageNo: "$pageNo"
    });
    var grievanceList = await _apiClient.post(
        path: ApiConst.wsGetGrievanceList,
        formData: FormData.fromMap({
          ApiConst.adminId:
              UserData.fromJson(GetStorage().read(DbKeys.userData)).idAdmin,
          ApiConst.filterType: selectedFilterCard.value,
          ApiConst.grievanceStatusId: selectedStatus.value,
          ApiConst.customerName: customerController.text,
          ApiConst.address: loactionController.text,
          ApiConst.adminDepartment: tempDepartmentId,
          ApiConst.dateType: selectedDateType.value,
          ApiConst.dateFrom: fromDate.text,
          ApiConst.dateTo: toDate.text,
          ApiConst.noOfRequestsPerPage: "20",
          ApiConst.pageNo: "$pageNo"
        }));

    if (grievanceList != null) {
      GrievenceListModel grievenceListModel =
          GrievenceListModel.fromJson(grievanceList);
      grievanceDetails.addAll(grievenceListModel.data!);
    } else {
      grievanceDetails.clear();
    }
  }

  Future<void> loadCount() async {
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var countJson = await _apiClient
        .post(path: ApiConst.wsGetGrievanceNumbersForAllTabs, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.filterType: selectedFilterCard.value,
      ApiConst.grievanceStatusId: selectedStatus.value,
      ApiConst.customerName: customerController.text,
      ApiConst.address: loactionController.text,
      ApiConst.adminDepartment: tempDepartmentId,
      ApiConst.dateType: selectedDateType.value,
      ApiConst.dateFrom: fromDate.text,
      ApiConst.dateTo: toDate.text,
      ApiConst.noOfRequestsPerPage: "20",
      ApiConst.pageNo: "$pageNo"
    });
    if (countJson != null) {
      AllGrievanceTabCountModel allGrievanceTabCountModel =
          AllGrievanceTabCountModel.fromJson(countJson);
      if (allGrievanceTabCountModel.status ?? false) {
        allTabCount.value = allGrievanceTabCountModel;
      }
    }
  }

  Future<void> loadPermissions() async {
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var permissionJson = await _apiClient.put(
        path: ApiConst.wsGetUserPermissionsByRole,
        formData: {ApiConst.roleIds: userData.adminType ?? ""});
    if (permissionJson != null) {
      UserPermissionByRoleModel userPermissionByRoleModel =
          UserPermissionByRoleModel.fromJson(permissionJson);
      if (userPermissionByRoleModel.status ?? false) {
        permissions = userPermissionByRoleModel.data!
            .firstWhere(
                (element) => element.permissionName == "Manage Grievances")
            .accessMode!
            .split(",");
      }
    }
  }

  Future<void> getAllStatus() async {
    var allStatusJson = await _apiClient.get(path: ApiConst.wsGetAllStatus);
    if (allStatusJson != null) {
      var getAllStatusModel = GetAllStatusModel.fromJson(allStatusJson);
      if (getAllStatusModel.status! && getAllStatusModel.data!.isNotEmpty) {
        allStatus.value = getAllStatusModel.data!
            .map((e) => DropDownDataModel(
                text: e.status ?? "", value: e.idStatus ?? ""))
            .toList();
        allStatus.insert(0, DropDownDataModel(text: "- All -", value: ""));
      }
    }
  }
}
