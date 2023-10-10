import 'package:get/get.dart';
import 'package:grievance_admin/app/core/api_client.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient(), permanent: true);
  }
}
