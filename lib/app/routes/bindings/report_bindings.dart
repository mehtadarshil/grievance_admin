import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/report_page/controller/report_controller.dart';

class ReportBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ReportController());
  }
}
