import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/alert_page/controller/alert_page_controller.dart';

class AlertBingings extends Bindings {
  @override
  void dependencies() {
    Get.put(AlertPageController());
  }
}
