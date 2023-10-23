import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/change_grievance_status/controller/change_grievance_status_controller.dart';

class ChangeGrievanceStatusBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangeGrievanceStatusController());
  }
}
