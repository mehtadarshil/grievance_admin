import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/utils/dbkeys.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = Get.find();
  RxBool signInCheck = false.obs;

  void signIn() async {
    var signInJson = await _apiClient.post(path: ApiConst.wsCheckLogin, body: {
      ApiConst.emailid: emailController.text,
      ApiConst.password: passwordController.text
    });

    if (signInJson != null) {
      SigninModel signinModel = SigninModel.fromJson(signInJson);
      if (signinModel.status!) {
        GetStorage().write(DbKeys.userData, signinModel.data!.first.toJson());
        Get.offAllNamed(RouteList.grievenceList);
      } else {}
    }
  }

  void signInCheckFun() {
    if (emailController.text.isEmail && passwordController.text.isNotEmpty) {
      signInCheck(true);
    } else {
      signInCheck(false);
    }
  }
}
