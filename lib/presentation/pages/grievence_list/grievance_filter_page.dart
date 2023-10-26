import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
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
          const CommonDropdown(
            data: [],
            value: '',
          ).paddingOnly(bottom: 22),
          CommonTextField(
            controller: controller.loactionController,
            hintText: 'Search_google_address'.tr,
            borderColor: AppColors.borderColor,
            title: "Location".tr,
            onChange: (value) {},
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.shape.svg(height: 18, width: 18),
              ],
            ),
          ).paddingOnly(bottom: 22),
          Opacity(
            opacity: 0.6,
            child: Text(
              "Sort_By_Date".tr,
              style: const TextStyle(
                  fontFamily: FontFamily.urbanistMedium, fontSize: 16),
            ),
          ).paddingOnly(bottom: 11),
          const CommonDropdown(
            data: [],
            value: '',
          ).paddingOnly(bottom: 22),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 30),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: CommonButton(
              text: "Reset_Filters".tr,
              color: AppColors.lightButtonColor,
              textColor: AppColors.textColor,
              onTap: () {},
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: CommonButton(
              text: "Search".tr,
              onTap: () {},
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 30),
    );
  }
}
