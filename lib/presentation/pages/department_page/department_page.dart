import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class DepartmentPage extends GetView<GrievenceListController> {
  const DepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CommonAppbar(title: "Department".tr),
      body: Obx(
        () => controller.departmentModel.value != null
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                itemCount: controller.departmentModel.value!.data!.length,
                itemBuilder: (context, index) {
                  var data = controller.departmentModel.value!.data![index];
                  return GestureDetector(
                    onTap: () {
                      controller.selectedDepartmentId.value =
                          data.idDepartment!;
                      controller.tempDepartmentName = data.departmentName ?? "";
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.departmentName ?? "",
                              style: const TextStyle(
                                  fontFamily: FontFamily.urbanistMedium,
                                  fontSize: 16),
                            ).paddingSymmetric(horizontal: 21, vertical: 21),
                          ),
                          Obx(
                            () => Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                value: data.idDepartment,
                                groupValue:
                                    controller.selectedDepartmentId.value,
                                onChanged: (value) {
                                  controller.selectedDepartmentId.value =
                                      value!;
                                  controller.tempDepartmentName =
                                      data.departmentName ?? "";
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : const SizedBox.shrink(),
      ),
      bottomNavigationBar: CommonButton(
        text: "Add".tr,
        onTap: () {
          controller.departmentController.text = controller.tempDepartmentName;
          controller.tempDepartmentId = controller.selectedDepartmentId.value;
          Get.back();
        },
      ).paddingSymmetric(horizontal: 20, vertical: 33),
    );
  }
}
