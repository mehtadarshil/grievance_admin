import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';

class GrievenceListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GrievenceListController());
  }
}
