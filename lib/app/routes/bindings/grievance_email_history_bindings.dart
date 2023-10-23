import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/grivance_email_history/controller/grievance_email_history_controller.dart';

class GrievanceEmailHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GrievanceEmailHistoryController());
  }
}
