import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/grievance_files_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:intl/intl.dart';

class EditGrievanceController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final resolutionDateController = TextEditingController();
  final resolutionTimeController = TextEditingController();
  final grievanceDetailController = TextEditingController();

  Rxn<GrievanceFilesModel> grievanceFiles = Rxn<GrievanceFilesModel>();

  @override
  void onReady() {
    getGrievanceFiles();
    assignValues();
    super.onReady();
  }

  void assignValues() {
    nameController.text = grievanceModel.customerName ?? "";
    addressController.text = grievanceModel.address ?? "";
    resolutionDateController.text =
        DateFormat("dd MMM").format(grievanceModel.createdOn!);
    resolutionTimeController.text =
        DateFormat("hh:mm aa").format(grievanceModel.createdOn!);
    grievanceDetailController.text = grievanceModel.remarks ?? "";
  }

  void getGrievanceFiles() async {
    var grievanceFileJson = await _apiClient.put(
        path: ApiConst.wsGetGrievanceFilesByGrivanceid,
        formData: {ApiConst.grievanceId: grievanceModel.idRequest ?? ""});

    if (grievanceFileJson != null) {
      GrievanceFilesModel grievanceFilesModel =
          GrievanceFilesModel.fromJson(grievanceFileJson);
      if (grievanceFilesModel.status ?? false) {
        grievanceFiles.value = grievanceFilesModel;
      }
    }
  }
}
