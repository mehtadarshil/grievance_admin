import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_autocomplete_flutter/google_places_autocomplete_flutter.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_dropdown_widget.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';

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
              },
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: CommonButton(
              text: "Search".tr,
              onTap: () {
                Get.back();
                controller.getGrievanceList();
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 30),
    );
  }
}
