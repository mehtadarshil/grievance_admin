import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';

class GrievenceListController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  Rxn<GrievenceListModel> grievanceDetails = Rxn<GrievenceListModel>();
  final ApiClient _apiClient = Get.find();

  @override
  void onInit() {
    getGrievanceList();
    super.onInit();
  }

  void getGrievanceList() async {
    var grievanceList = await _apiClient.post(
        path: ApiConst.wsGetGrievanceList,
        formData: FormData.fromMap({
          ApiConst.adminId:
              UserData.fromJson(GetStorage().read(DbKeys.userData)).idAdmin
        }));

    if (grievanceList != null) {
      GrievenceListModel grievenceListModel =
          GrievenceListModel.fromJson(grievanceList);
      grievanceDetails.value = grievenceListModel;
    }
  }
}
