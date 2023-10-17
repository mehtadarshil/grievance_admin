import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/sign_in_page/controller/sign_in_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: "grievance_admin".tr, splitTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.lightOrangeColor,
                  border: Border(
                      left: BorderSide(
                          width: 5, color: AppColors.primaryRedColor))),
              child: Text(
                "Sign_in_to_start_your_session".tr,
                style: TextStyle(
                    fontFamily: FontFamily.urbanistMedium,
                    fontSize: 16,
                    color: AppColors.primaryRedColor),
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            CommonTextField(
              hintText: "Email".tr,
              controller: controller.emailController,
              title: "Email".tr,
              onChange: (value) {
                controller.signInCheckFun();
              },
            ),
            const SizedBox(
              height: 27,
            ),
            CommonTextField(
              hintText: "Password".tr,
              controller: controller.passwordController,
              title: "Password".tr,
              obscureText: true,
              onChange: (value) {
                controller.signInCheckFun();
              },
            ),
            const SizedBox(
              height: 52,
            ),
            Obx(
              () => Opacity(
                opacity: controller.signInCheck.value ? 1 : 0.5,
                child: CommonButton(
                  text: "Sign_In".tr,
                  onTap: controller.signInCheck.value
                      ? () {
                          controller.signIn();
                        }
                      : () {},
                ),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
