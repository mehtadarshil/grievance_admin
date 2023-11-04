import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/edit_grievance_page/controller/edit_grievance_controller.dart';

class EditGrievanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EditGrievanceController());
  }
}
