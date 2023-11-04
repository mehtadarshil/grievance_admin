import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/grievance_files_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/models/transfer_grievance_model.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:intl/intl.dart';

class EditGrievanceController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final resolutionDateController = TextEditingController();
  final resolutionTimeController = TextEditingController();
  final grievanceDetailController = TextEditingController();
  GrievenceListController grievenceListController = Get.find();

  final UserData _userData =
      UserData.fromJson(GetStorage().read(DbKeys.userData));

  RxList<PlatformFile> pickedFiles = <PlatformFile>[].obs;

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
    grievanceDetailController.text = grievanceModel.requestDescription ?? "";
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
      } else {
        grievanceFiles.value = null;
      }
    }
  }

  void pickFiles() async {
    var pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (pickedFile != null) {
      pickedFiles.add(pickedFile.files.first);
    }
  }

  void deleteImage({required String imageID, required String imageName}) async {
    var deleteImageJson = await _apiClient.post(
        path: ApiConst.wsDeleteGrievanceImage,
        body: {ApiConst.imageId: imageID, ApiConst.imageName: imageName});
    if (deleteImageJson != null) {
      TransferGrievanceModel deleteImageModel =
          TransferGrievanceModel.fromJson(deleteImageJson);
      if (deleteImageModel.status ?? false) {
        getGrievanceFiles();
      }
    }
  }

  void updateGrievance() async {
    var formData = FormData.fromMap({
      ApiConst.loggedinAdminId: _userData.idAdmin,
      ApiConst.grievanceId: grievanceModel.idRequest,
      ApiConst.departmentIds: grievanceModel.departmentIds,
      ApiConst.grievanceStatus: grievanceModel.requestStatus,
      ApiConst.grievanceDetails: grievanceDetailController.text
    });
    if (pickedFiles.isNotEmpty) {
      for (var element in pickedFiles) {
        formData.files.add(MapEntry(
            ApiConst.grievanceImage,
            await MultipartFile.fromFile(element.path!,
                filename: element.name)));
      }
    }
    var updateGrievanceJson = await _apiClient.post(
        path: ApiConst.wsUpdateGrievance, formData: formData);
    if (updateGrievanceJson != null) {
      TransferGrievanceModel updateGrievanceModel =
          TransferGrievanceModel.fromJson(updateGrievanceJson);
      if (updateGrievanceModel.status ?? false) {
        DialogUtil.customDialog(
          title: updateGrievanceModel.data!.message ?? "",
          onTap: () {
            grievenceListController.getGrievanceList();
            Get.close(2);
          },
        );
      }
    }
  }
}
