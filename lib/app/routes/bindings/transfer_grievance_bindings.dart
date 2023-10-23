import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/transfer_grievance/controller/transfer_grievance_controller.dart';

class TransferGrievanceBindigns extends Bindings {
  @override
  void dependencies() {
    Get.put(TransferGrievanceController());
  }
}
