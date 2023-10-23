import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/send_message/controller/send_message_controller.dart';

class SendMessageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SendMessageController());
  }
}
