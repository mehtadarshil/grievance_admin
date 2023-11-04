// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/controller/dashboard_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';

class StatusMultiPage extends GetView<DashboardController> {
  const StatusMultiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: ("Status".tr).replaceAll(":", "")),
      body: Obx(() => controller.allStatusModel.value == null
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
                        value: controller.selectedStatusIds.value.length ==
                            controller.allStatusModel.value!.data!.length,
                        onChanged: (value) {
                          if (value!) {
                            for (var element
                                in controller.allStatusModel.value!.data!) {
                              controller.selectedStatusIds
                                  .add(element.idStatus!);
                            }
                          } else {
                            controller.selectedStatusIds.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = controller.allStatusModel.value!.data![index];
                      return ListTile(
                        title: Text(data.status!),
                        trailing: Obx(
                          () => Checkbox(
                            value: controller.selectedStatusIds.value
                                .contains(data.idStatus),
                            onChanged: (value) {
                              if (value!) {
                                controller.selectedStatusIds
                                    .add(data.idStatus!);
                              } else {
                                controller.selectedStatusIds
                                    .remove(data.idStatus);
                              }
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: controller.allStatusModel.value!.data!.length,
                  ),
                ],
              ),
            )),
    );
  }
}
