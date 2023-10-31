import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/app/models/get_all_status_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/models/transfer_grievance_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:grievance_admin/utils/logger.dart';

class ChangeGrievanceStatusController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  final TextEditingController remarkController = TextEditingController();
  RxList<DropDownDataModel> allStatus = <DropDownDataModel>[].obs;
  RxString selectedStatus = "".obs;
  Rxn<PlatformFile> file = Rxn<PlatformFile>();
  RxBool isValid = false.obs;

  @override
  void onReady() {
    getAllStatus();
    super.onReady();
  }

  void pickUpFile() async {
    var pickedFile = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (pickedFile != null) {
      file.value = pickedFile.files.first;
      Logger.prints(file.value?.name);
    }
  }

  void getAllStatus() async {
    var allStatusJson = await _apiClient.get(path: ApiConst.wsGetAllStatus);
    if (allStatusJson != null) {
      var getAllStatusModel = GetAllStatusModel.fromJson(allStatusJson);
      if (getAllStatusModel.status! && getAllStatusModel.data!.isNotEmpty) {
        allStatus.value = getAllStatusModel.data!
            .map((e) => DropDownDataModel(
                text: e.status ?? "", value: e.idStatus ?? ""))
            .toList();
        selectedStatus.value =
            grievanceModel.requestStatus ?? allStatus.first.value;
      }
    }
  }

  void changeGrievanceStatus() async {
    FormData formData = FormData.fromMap({
      ApiConst.loggedinAdminId:
          UserData.fromJson(GetStorage().read(DbKeys.userData)).idAdmin,
      ApiConst.grievanceId: grievanceModel.idRequest,
      ApiConst.grievanceStatus: selectedStatus.value,
      ApiConst.requestPreviousStatus: grievanceModel.status,
      ApiConst.remarks: remarkController.text,
    });
    if (file.value != null) {
      formData.files.add(MapEntry(
          ApiConst.grievanceStatusImage,
          await MultipartFile.fromFile(file.value!.path!,
              filename: file.value?.name ?? "")));
    }

    var changeGrievanceStatusJson = await _apiClient.post(
        path: ApiConst.wsUpdateGrievanceStatus, formData: formData);
    if (changeGrievanceStatusJson != null) {
      TransferGrievanceModel changeGrievanceModel =
          TransferGrievanceModel.fromJson(changeGrievanceStatusJson);
      if (changeGrievanceModel.status ?? false) {
        DialogUtil.customDialog(
            title: changeGrievanceModel.data?.message ?? "");
      } else {
        DialogUtil.customDialog(title: "Failed".tr, error: false);
      }
    }
  }
}
