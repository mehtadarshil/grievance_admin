import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';

class TransferGrievanceController extends GetxController {
  GDatum grievanceModel = Get.arguments;
  final ApiClient _apiClient = Get.find();
  final TextEditingController transferReasonController =
      TextEditingController();
}
