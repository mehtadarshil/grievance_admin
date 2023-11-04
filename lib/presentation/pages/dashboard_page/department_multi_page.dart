// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/controller/dashboard_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';

class DepartmentMultiPage extends GetView<DashboardController> {
  const DepartmentMultiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: ("Department".tr).replaceAll(":", "")),
      body: Obx(() => controller.departmentModel.value == null
          ? const Center(
              child: Text("No Data Found"),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Select All"),
                    trailing: Obx(
                      () => Checkbox(
                        value: controller.selectedDepartmentIds.value.length ==
                            controller.departmentModel.value!.data!.length,
                        onChanged: (value) {
                          if (value!) {
                            for (var element
                                in controller.departmentModel.value!.data!) {
                              controller.selectedDepartmentIds
                                  .add(element.idDepartment!);
                            }
                          } else {
                            controller.selectedDepartmentIds.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = controller.departmentModel.value!.data![index];
                      return ListTile(
                        title: Text(data.departmentName!),
                        trailing: Obx(
                          () => Checkbox(
                            value: controller.selectedDepartmentIds.value
                                .contains(data.idDepartment),
                            onChanged: (value) {
                              if (value!) {
                                controller.selectedDepartmentIds
                                    .add(data.idDepartment!);
                              } else {
                                controller.selectedDepartmentIds
                                    .remove(data.idDepartment);
                              }
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: controller.departmentModel.value!.data!.length,
                  ),
                ],
              ),
            )),
    );
  }
}
