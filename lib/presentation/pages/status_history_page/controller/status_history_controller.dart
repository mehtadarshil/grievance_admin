import 'package:get/get.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/models/status_history_model.dart';

class StatusHistoryController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  Rxn<StatusHistoryModel> statusHistory = Rxn<StatusHistoryModel>();

  @override
  void onReady() {
    getStatusHistory();
    super.onReady();
  }

  void getStatusHistory() async {
    var statusHistoryJson = await _apiClient.put(
        path: ApiConst.wsGetGrievanceStatusHistoryByGrivanceid,
        formData: {ApiConst.grievanceId: grievanceModel.idRequest ?? ""});
    if (statusHistoryJson != null) {
      StatusHistoryModel statusHistoryModel =
          StatusHistoryModel.fromJson(statusHistoryJson);
      if (statusHistoryModel.status ?? false) {
        statusHistory.value = statusHistoryModel;
      }
    }
  }
}
