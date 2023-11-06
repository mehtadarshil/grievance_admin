import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/assign_department_model.dart';
import 'package:grievance_admin/app/models/department_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/dialog_util.dart';

class AssignGrievanceController extends GetxController {
  final GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  Rxn<DepartmentModel> departmentModel = Rxn<DepartmentModel>();
  RxString selectedDepartmentID = "".obs;

  Future<void> getDepartments() async {
    var departJson = await _apiClient.get(path: ApiConst.wsGetAllDepartments);
    if (departJson != null) {
      var departmentData = DepartmentModel.fromJson(departJson);
      if (departmentData.status ?? false) {
        departmentModel.value = departmentData;
        selectedDepartmentID.value =
            departmentData.data!.first.idDepartment ?? "";
      }
    }
  }

  Future<void> assignDepartment() async {
    UserData userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
    var assignDepartmentJson = await _apiClient
        .post(path: ApiConst.wsAssignGrievanceToDepartment, body: {
      ApiConst.adminId: userData.idAdmin,
      ApiConst.grievanceId: grievanceModel.idRequest,
      ApiConst.departmentId: selectedDepartmentID.value,
      ApiConst.grievanceCurrentStatus: grievanceModel.status
    });
    if (assignDepartmentJson != null) {
      AssignDepartmentModel assignDepartmentModel =
          AssignDepartmentModel.fromJson(assignDepartmentJson);

      if (assignDepartmentModel.status ?? false) {
        DialogUtil.customDialog(
          title: assignDepartmentModel.data?.message ?? "",
          onTap: () {
            Get.close(2);
          },
        );
      }
    }
  }

  @override
  void onReady() {
    getDepartments();
    super.onReady();
  }
}
