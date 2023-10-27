import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/status_history_page/controller/status_history_controller.dart';

class StatusHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StatusHistoryController());
  }
}
