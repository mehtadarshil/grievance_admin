import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/get_all_status_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';

class ChangeGrievanceStatusController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  final TextEditingController remarkController = TextEditingController();

  void getAllStatus() async {
    var allStatusJson = await _apiClient.get(path: ApiConst.wsGetAllStatus);
    if (allStatusJson != null) {
      var getAllStatusModel = GetAllStatusModel.fromJson(allStatusJson);
    }
  }
}
