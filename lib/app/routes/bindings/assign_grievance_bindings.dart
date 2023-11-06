import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/assign_grievance/controller/assign_grievance_controller.dart';

class AssignGrievanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AssignGrievanceController());
  }
}
