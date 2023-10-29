import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/all_grievance_tab_count_model.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/app/models/filter_card_model.dart';
import 'package:grievance_admin/app/models/get_all_status_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/models/user_permission_by_role_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';

class GrievenceListController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController loactionController = TextEditingController();

  Rxn<GrievenceListModel> grievanceDetails = Rxn<GrievenceListModel>();
  final ApiClient _apiClient = Get.find();
  RxString selectedFilterCard = "throughput".obs;
  RxList<DropDownDataModel> allStatus = <DropDownDataModel>[].obs;
  RxString selectedStatus = "".obs;
  List<String> permissions = [];
  Rxn<AllGrievanceTabCountModel> allTabCount = Rxn<AllGrievanceTabCountModel>();

  List<FilterCardModel> filterCardData = [
    FilterCardModel(title: "Grievance", value: "throughput"),
    FilterCardModel(title: "Pending", value: "pendency"),
    FilterCardModel(title: "Transferred", value: "transferred"),
    FilterCardModel(
        title: "Unassigned Grievances", value: "unassignedgrievance"),
    FilterCardModel(title: "Resoved/Closed", value: "closedresolved")
  ];

  @override
  void onReady() {
    getGrievanceList().then((value) async {
      await loadCount();
      await getAllStatus();
      await loadPermissions();
    });
    super.onReady();
  }

  Future<void> getGrievanceList() async {
    var grievanceList = await _apiClient.post(
        path: ApiConst.wsGetGrievanceList,
        formData: FormData.fromMap({
          ApiConst.adminId:
              UserData.fromJson(GetStorage().read(DbKeys.userData)).idAdmin,
          ApiConst.filterType: selectedFilterCard.value,
          ApiConst.grievanceStatusId: selectedStatus.value,
          ApiConst.customerName: customerController.text,
          ApiConst.address: loactionController.text
        }));

    if (grievanceList != null) {
      GrievenceListModel grievenceListModel =
          GrievenceListModel.fromJson(grievanceList);
      grievanceDetails.value = grievenceListModel;
    }
  }

  Future<void> loadCount() async {
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var countJson = await _apiClient.post(
        path: ApiConst.wsGetGrievanceNumbersForAllTabs,
        body: {ApiConst.adminId: userData.idAdmin ?? ""});
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
