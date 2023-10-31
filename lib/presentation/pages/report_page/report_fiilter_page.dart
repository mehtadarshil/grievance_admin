import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/presentation/pages/report_page/controller/report_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_dropdown_widget.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:intl/intl.dart';

class ReportFilterPage extends GetView<ReportController> {
  const ReportFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: "Filters".tr),
      body: Column(
        children: [
          Obx(() => CommonDropdown(
                data: controller.dropdownData,
                title: "Sort_By_Date".tr,
                value: controller.selectedDateType.value,
                onChange: (value) {
                  controller.selectedDateType.value = value.toString();
                  controller.isValidCheck();
                },
              )).paddingOnly(bottom: 11),
          Obx(
            () => Visibility(
              visible: controller.selectedDateType.value == "custom",
              child: CommonTextField(
                hintText: "From".tr,
                controller: controller.fromDate,
                title: "From".tr,
                onTap: () async {
                  var fromDate = await DialogUtil.showDatePickerDialog();
                  if (fromDate != null) {
                    controller.fromDate.text =
                        DateFormat("MM/dd/yyyy").format(fromDate);
                    controller.isValidCheck();
                  }
                },
              ).paddingOnly(bottom: 11),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.selectedDateType.value == "custom",
              child: CommonTextField(
                hintText: "To".tr,
                controller: controller.toDate,
                title: "To".tr,
                onTap: () async {
                  var toDate = await DialogUtil.showDatePickerDialog();
                  if (toDate != null) {
                    controller.toDate.text =
                        DateFormat("MM/dd/yyyy").format(toDate);
                    controller.isValidCheck();
                  }
                },
              ),
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 21, vertical: 20),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: CommonButton(
              text: "Reset_Filters".tr,
              color: AppColors.lightButtonColor,
              textColor: AppColors.textColor,
              onTap: () {
                controller.selectedDateType.value = "";
                controller.fromDate.clear();
                controller.toDate.clear();
              },
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Obx(
              () => Opacity(
                opacity: controller.isValid.value ? 1 : 0.5,
                child: CommonButton(
                  text: "Search".tr,
                  onTap: controller.isValid.value
                      ? () async {
                          if (controller.selectedDateType.value == "custom") {
                            await controller.getReportData();
                            await controller.getReportCount();
                          } else {
                            controller.fromDate.clear();
                            controller.toDate.clear();
                            await controller.getReportData();
                            await controller.getReportCount();
                          }
                          Get.back();
                        }
                      : () {},
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 30),
    );
  }
}
