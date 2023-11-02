import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/alert_data_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';

class AlertPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiClient _apiClient = ApiClient();
  final UserData _userData =
      UserData.fromJson(GetStorage().read(DbKeys.userData));
  Rxn<AlertDataModel> alertData = Rxn<AlertDataModel>();
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    getAlertData();
    super.onReady();
  }

  void getAlertData() async {
    var alertDataJson = await _apiClient.post(
        path: ApiConst.wsGetUnreadStatusAndEmailUpdates,
        body: {
          ApiConst.adminId: _userData.idAdmin,
          ApiConst.adminType: _userData.adminType
        });
    if (alertDataJson != null) {
      AlertDataModel alertDataModel = AlertDataModel.fromJson(alertDataJson);
      if (alertDataModel.status ?? false) {
        alertData.value = alertDataModel;
      }
    }
  }
}
