import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_autocomplete_flutter/google_places_autocomplete_flutter.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/department_page/department_page.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_dropdown_widget.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:intl/intl.dart';

class GrievanceFilterPage extends GetView<GrievenceListController> {
  const GrievanceFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: "Filters".tr),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
                    borderColor: AppColors.borderColor,
                    hintText: "Enter_here".tr,
                    title: "Customer".tr,
                    controller: controller.customerController)
                .paddingOnly(bottom: 22),
            CommonTextField(
                    borderColor: AppColors.borderColor,
                    hintText: "Enter_here".tr,
                    title: "Department".tr,
                    onTap: () {
                      if (controller.tempDepartmentId.isNotEmpty) {
                        controller.selectedDepartmentId.value =
                            controller.tempDepartmentId;
                      }
                      Get.to(() => const DepartmentPage());
                    },
                    controller: controller.departmentController)
                .paddingOnly(bottom: 22),
            Opacity(
              opacity: 0.6,
              child: Text(
                "Status_normal".tr,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistMedium, fontSize: 16),
              ),
            ).paddingOnly(bottom: 11),
            Obx(
              () => CommonDropdown(
                data: controller.allStatus.value,
                value: controller.selectedStatus.value,
                onChange: (value) {
                  controller.selectedStatus.value = value.toString();
                },
              ).paddingOnly(bottom: 22),
            ),
            Opacity(
              opacity: 0.6,
              child: Text(
                "Location".tr,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistMedium, fontSize: 16),
              ),
            ).paddingOnly(bottom: 11),
            GooglePlaceAutoCompleteFlutterTextField(
              textEditingController: controller.loactionController,
              googleAPIKey: "AIzaSyAa2DDyBCbm_HxtxGGGm367ao_NrSHOiFc",
              debounceTime: 300,
              inputDecoration: InputDecoration(
                  filled: true,
                  hintText: 'Search_google_address'.tr,
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.shape.svg(height: 18, width: 18),
                    ],
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                  hintStyle: TextStyle(
                      fontFamily: FontFamily.urbanistMedium,
                      fontSize: 16,
                      color: AppColors.textColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.borderColor, width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.borderColor, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.borderColor, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.borderColor, width: 1)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.borderColor, width: 1)),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppColors.borderColor, width: 1),
                  ),
                  fillColor: AppColors.whiteColor),
              itmClick: (postalCodeResponse) {
                controller.loactionController.text =
                    postalCodeResponse.description ?? "";
              },
            ).paddingOnly(bottom: 22),
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
                  borderColor: AppColors.borderColor,
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
                  borderColor: AppColors.borderColor,
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
            // Opacity(
            //   opacity: 0.6,
            //   child: Text(
            //     "Sort_By_Date".tr,
            //     style: const TextStyle(
            //         fontFamily: FontFamily.urbanistMedium, fontSize: 16),
            //   ),
            // ).paddingOnly(bottom: 11),
            // const CommonDropdown(
            //   data: [],
            //   value: '',
            // ).paddingOnly(bottom: 22),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 30),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: CommonButton(
              text: "Reset_Filters".tr,
              color: AppColors.lightButtonColor,
              textColor: AppColors.textColor,
              onTap: () {
                controller.customerController.clear();
                controller.loactionController.clear();
                controller.selectedStatus.value = "";
                controller.departmentController.clear();
                controller.tempDepartmentId = "";
                controller.selectedDateType.value = "";
                controller.isValidCheck();
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
                      ? () {
                          controller.grievanceDetails.clear();
                          controller.pageNo = 1;
                          Get.back();
                          controller.getGrievanceList().then((value) {
                            controller.loadCount();
                          });
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
