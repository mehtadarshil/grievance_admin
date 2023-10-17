import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/sign_in_page/controller/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
