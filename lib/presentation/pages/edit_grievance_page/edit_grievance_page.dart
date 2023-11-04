import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/edit_grievance_page/controller/edit_grievance_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dialog_util.dart';

class EditGrievancePage extends GetView<EditGrievanceController> {
  const EditGrievancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppbar(title: "Edit_Grievance".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Gievance_Id".tr,
                    style: TextStyle(
                        fontFamily: FontFamily.urbanistMedium,
                        fontSize: 16,
                        color: AppColors.textColor.withOpacity(0.5)),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      controller.grievanceModel.uniqueRequestId ?? "",
                      style: TextStyle(
                          fontFamily: FontFamily.urbanistSemiBold,
                          fontSize: 16,
                          color: AppColors.textColor),
                    ),
                  ),
                )
              ],
            ).paddingSymmetric(vertical: 26, horizontal: 20),
            Divider(
              color: AppColors.borderColor,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "${"Description".tr}: ",
                    style: TextStyle(
                        fontFamily: FontFamily.urbanistMedium,
                        fontSize: 16,
                        color: AppColors.textColor.withOpacity(0.5)),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      controller.grievanceModel.departmentNames ?? "",
                      style: TextStyle(
                          fontFamily: FontFamily.urbanistSemiBold,
                          fontSize: 16,
                          color: AppColors.textColor),
                    ),
                  ),
                )
              ],
            ).paddingSymmetric(vertical: 26, horizontal: 20),
            Divider(
              color: AppColors.borderColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  hintText: "Name".tr,
                  controller: controller.nameController,
                  title: "Name".tr,
                  borderColor: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  hintText: "Address".tr,
                  controller: controller.addressController,
                  title: "Address".tr,
                  borderColor: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  hintText: "Resolution_Date".tr,
                  controller: controller.resolutionDateController,
                  title: "Resolution_Date".tr,
                  borderColor: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  hintText: "Resolution_Time".tr,
                  controller: controller.resolutionTimeController,
                  title: "Resolution_Time".tr,
                  borderColor: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  hintText: "Grievance_Details".tr,
                  controller: controller.grievanceDetailController,
                  title: "Grievance_Details".tr,
                  borderColor: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: AppColors.borderColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      controller.pickFiles();
                    },
                    child: Assets.images.uploadImage.image()),
                const SizedBox(
                  height: 57,
                ),
                Text(
                  "View_Download_Files".tr,
                  style: const TextStyle(
                      fontFamily: FontFamily.urbanistMedium, fontSize: 16),
                ),
                Obx(() => controller.pickedFiles.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = controller.pickedFiles[index];
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.name,
                                  style: TextStyle(
                                      color: AppColors.primaryBlueColor),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pickedFiles.removeWhere(
                                      (element) => element.name == data.name);
                                },
                                child: Container(
                                  color: AppColors.eighthActionColor,
                                  child: Text(
                                    "Delete".tr,
                                    style: const TextStyle(
                                        fontFamily: FontFamily.urbanistMedium,
                                        fontSize: 12),
                                  ).paddingSymmetric(
                                      vertical: 8, horizontal: 11),
                                ),
                              )
                            ],
                          ).paddingSymmetric(vertical: 25);
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: AppColors.borderColor,
                            ),
                        itemCount: controller.pickedFiles.length)),
                Obx(() => controller.grievanceFiles.value == null
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data =
                              controller.grievanceFiles.value!.data![index];
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.requestImageName ?? "",
                                  style: TextStyle(
                                      color: AppColors.primaryBlueColor),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  DialogUtil.confirmationAlert(
                                    onConfirm: () {
                                      Get.back();
                                      controller.deleteImage(
                                          imageID: data.requestImageId!,
                                          imageName: data.requestImageName!);
                                    },
                                  );
                                },
                                child: Container(
                                  color: AppColors.eighthActionColor,
                                  child: Text(
                                    "Delete".tr,
                                    style: const TextStyle(
                                        fontFamily: FontFamily.urbanistMedium,
                                        fontSize: 12),
                                  ).paddingSymmetric(
                                      vertical: 8, horizontal: 11),
                                ),
                              )
                            ],
                          ).paddingSymmetric(vertical: 25);
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: AppColors.borderColor,
                            ),
                        itemCount:
                            controller.grievanceFiles.value!.data!.length)),
                const SizedBox(
                  height: 57,
                )
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
      bottomNavigationBar: CommonButton(
        text: "Save".tr,
        onTap: () {
          controller.updateGrievance();
        },
      ).paddingSymmetric(horizontal: 20, vertical: 25),
    );
  }
}
