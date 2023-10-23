import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/grievance_email_history_model.dart';
import 'package:grievance_admin/utils/dialog_util.dart';

class GrievanceEmailHistoryController extends GetxController {
  final ApiClient _apiClient = Get.find();
  Rxn<GrievenceEmailHistoryModel> emailHistory =
      Rxn<GrievenceEmailHistoryModel>();
  String grievanceId = Get.arguments;

  @override
  void onReady() {
    getEmailHistory();
    super.onReady();
  }

  void getEmailHistory() async {
    final historyJson = await _apiClient.post(
        path: ApiConst.wsGetEmailHistoryByGrievanceId,
        formData: FormData.fromMap({ApiConst.grievanceId: grievanceId}));
    if (historyJson != null) {
      var grievanceEmailHistory =
          GrievenceEmailHistoryModel.fromJson(historyJson);
      if (grievanceEmailHistory.status!) {
        emailHistory.value = grievanceEmailHistory;
      } else {
        DialogUtil.customDialog(title: "Failed".tr, error: true);
      }
    }
  }
}
