import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_dropdown_widget.dart';
import 'package:grievance_admin/utils/appcolors.dart';

import 'controller/assign_grievance_controller.dart';

class AssignGrievancePage extends GetView<AssignGrievanceController> {
  const AssignGrievancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: "Assign_Department".tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "${"Grievance_Details".tr} : ",
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
            ])).paddingOnly(bottom: 22),
            Obx(() => controller.departmentModel.value == null
                ? const SizedBox.shrink()
                : CommonDropdown(
                    data: controller.departmentModel.value!.data!
                        .map((e) => DropDownDataModel(
                            text: e.departmentName!, value: e.idDepartment!))
                        .toList(),
                    value: controller.selectedDepartmentID.value,
                    onChange: (value) {
                      controller.selectedDepartmentID.value = value ?? "";
                    },
                  )).paddingOnly(bottom: 22),
            CommonButton(
              text: "Save".tr,
              onTap: () {
                controller.assignDepartment();
              },
            )
          ],
        ).paddingSymmetric(horizontal: 22, vertical: 15),
      ),
    );
  }
}
