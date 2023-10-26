import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/admin_users_model.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/models/transfer_grievance_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/dialog_util.dart';

class TransferGrievanceController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  final TextEditingController transferReasonController =
      TextEditingController();
  RxList<DropDownDataModel> adminUsersList = <DropDownDataModel>[].obs;
  RxString toAdminUserValue = "".obs;
  RxBool isValid = false.obs;

  @override
  void onReady() {
    getAdminUsers();
    super.onReady();
  }

  void getAdminUsers() async {
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var adminUsersJson = await _apiClient.post(
        path: ApiConst.wsGetAdminUsersByType,
        body: {ApiConst.adminType: userData.adminType});

    if (adminUsersJson != null) {
      AdminUsersModel adminUsersModel =
          AdminUsersModel.fromJson(adminUsersJson);
      if (adminUsersModel.status! && adminUsersModel.data!.isNotEmpty) {
        adminUsersList.value = adminUsersModel.data!
            .map((e) => DropDownDataModel(
                text: "${e.firstName ?? ""} ${e.lastName ?? ""}",
                value: e.idAdmin ?? ""))
            .toList();
        toAdminUserValue.value = adminUsersList.first.value;
        isValidCheck();
      } else {}
    }
  }

  void isValidCheck() {
    if (toAdminUserValue.value.isNotEmpty &&
        transferReasonController.text.isNotEmpty) {
      isValid(true);
    } else {
      isValid(false);
    }
  }

  void transferGrievance() async {
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var transferGrievance =
        await _apiClient.post(path: ApiConst.wstransferGrievance, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.transferredToAdminUser: toAdminUserValue.value,
      ApiConst.grievanceId: grievanceModel.idRequest,
      ApiConst.transferReason: transferReasonController.text,
      ApiConst.grievancePreviousStatus: grievanceModel.status
    });

    if (transferGrievance != null) {
      TransferGrievanceModel transferGrievanceModel =
          TransferGrievanceModel.fromJson(transferGrievance);
      if (transferGrievanceModel.status!) {
        DialogUtil.customDialog(
            title: transferGrievanceModel.data?.message ?? "");
      } else {
        DialogUtil.customDialog(
            title: transferGrievanceModel.message ?? "", error: true);
      }
    }
  }
}
