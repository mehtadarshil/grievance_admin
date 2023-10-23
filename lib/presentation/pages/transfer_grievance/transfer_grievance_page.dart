import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/transfer_grievance/controller/transfer_grievance_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class TransferGrievancePage extends GetView<TransferGrievanceController> {
  const TransferGrievancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppbar(title: "Transfer_Grievance".tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Current_Department".tr,
                  style: const TextStyle(
                    fontFamily: FontFamily.urbanistBold,
                    fontSize: 16,
                  )),
              TextSpan(
                  text: controller.grievanceModel.departmentNames,
                  style: TextStyle(
                      fontFamily: FontFamily.urbanistMedium,
                      fontSize: 16,
                      color: AppColors.color999999))
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Customer".tr,
                  style: const TextStyle(
                    fontFamily: FontFamily.urbanistBold,
                    fontSize: 16,
                  )),
              TextSpan(
                  text: controller.grievanceModel.customerName,
                  style: TextStyle(
                      fontFamily: FontFamily.urbanistMedium,
                      fontSize: 16,
                      color: AppColors.color999999))
            ])).paddingOnly(bottom: 16),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Grievance_Details".tr,
                  style: const TextStyle(
                    fontFamily: FontFamily.urbanistBold,
                    fontSize: 16,
                  )),
              TextSpan(
                  text: controller.grievanceModel.requestDescription,
                  style: TextStyle(
                      fontFamily: FontFamily.urbanistMedium,
                      fontSize: 16,
                      color: AppColors.color999999))
            ])).paddingOnly(bottom: 42),
            CommonTextField(
              hintText: "Transfer_Reason".tr,
              title: "Transfer_Reason".tr,
              controller: controller.transferReasonController,
              borderColor: AppColors.borderColor,
              maxLines: 7,
            )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 30),
      ),
      bottomNavigationBar: CommonButton(
        text: "Save".tr,
        onTap: () {},
      ).paddingSymmetric(horizontal: 20, vertical: 30),
    );
  }
}
