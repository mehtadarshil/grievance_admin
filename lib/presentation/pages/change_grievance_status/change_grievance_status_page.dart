// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/change_grievance_status/controller/change_grievance_status_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_dropdown_widget.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class ChangeGrievanceStatusPage
    extends GetView<ChangeGrievanceStatusController> {
  const ChangeGrievanceStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppbar(title: "Change_Grievance_Status".tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Status".tr,
                  style: const TextStyle(
                    fontFamily: FontFamily.urbanistBold,
                    fontSize: 16,
                  )),
              TextSpan(
                  text: controller.grievanceModel.status,
                  style: TextStyle(
                      fontFamily: FontFamily.urbanistMedium,
                      fontSize: 16,
                      color: AppColors.color999999))
            ])).paddingOnly(bottom: 11),
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
            Obx(() => CommonDropdown(
                  data: controller.allStatus.value,
                  value: controller.selectedStatus.value,
                  title: "Change_Status".tr,
                  onChange: (value) {
                    controller.selectedStatus.value = value.toString();
                  },
                )).paddingOnly(top: 37, bottom: 43),
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
            Obx(
              () => controller.file.value == null
                  ? GestureDetector(
                      onTap: () {
                        controller.pickUpFile();
                      },
                      child: Assets.images.uploadImage
                          .image()
                          .paddingOnly(bottom: 37))
                  : Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            controller.file.value?.name ?? "",
                            maxLines: 1,
                          )),
                          GestureDetector(
                            onTap: () {
                              controller.file.value = null;
                            },
                            child: Container(
                                color: Colors.transparent,
                                height: 15,
                                width: 15,
                                child: Assets.images.close.svg()),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 21),
                    ).paddingOnly(bottom: 30),
            ),
            CommonTextField(
              hintText: "Remarks".tr,
              title: "Remarks".tr,
              controller: controller.remarkController,
              borderColor: AppColors.borderColor,
              maxLines: 7,
              onChange: (value) {
                if (value.isNotEmpty) {
                  controller.isValid(true);
                } else {
                  controller.isValid(false);
                }
              },
            )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 30),
      ),
      bottomNavigationBar: Obx(
        () => Opacity(
          opacity: controller.isValid.value ? 1 : 0.5,
          child: CommonButton(
            text: "Save".tr,
            onTap: () {
              if (controller.isValid.value) {
                controller.changeGrievanceStatus();
              }
            },
          ),
        ),
      ).paddingSymmetric(horizontal: 20, vertical: 30),
    );
  }
}
