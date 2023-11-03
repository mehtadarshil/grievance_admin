import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/delete_grievance_model.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class DialogUtil {
  static void actionDialog(
          {required GDatum grievanceModel,
          required List<String> permissions}) =>
      showDialog(
        context: Get.context!,
        builder: (context) => ActionDialogWidget(
          grievanceModel: grievanceModel,
          permissions: permissions,
        ),
      );

  static void customDialog(
      {required String title, bool? error, VoidCallback? onTap}) {
    showDialog(
      context: Get.context!,
      builder: (context) => CustomDialogWidget(
        title: title,
        onTap: onTap,
        error: error ?? false,
      ),
    );
  }

  static Future<DateTime?> showDatePickerDialog() => showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: AppColors.primaryBlueColor,
                buttonTheme:
                    ButtonThemeData(buttonColor: AppColors.primaryBlueColor),
                colorScheme: const ColorScheme.light()
                    .copyWith(primary: AppColors.primaryBlueColor)),
            child: child!);
      },
      lastDate: DateTime.now());

  static void sortOrderDialog() => showDialog(
        context: Get.context!,
        builder: (context) => const SortOrderDialogWidget(),
      );

  static void confirmationAlert(
          {String? title, required VoidCallback onConfirm}) =>
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: Text(
            title ?? "delete_title".tr,
            style: const TextStyle(
                fontFamily: FontFamily.urbanistMedium, fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "cancel".tr,
                  style: TextStyle(
                      fontFamily: FontFamily.urbanistSemiBold,
                      fontSize: 16,
                      color: AppColors.primaryBlueColor),
                )),
            TextButton(
                onPressed: onConfirm,
                child: Text(
                  "confirm".tr,
                  style: TextStyle(
                      fontFamily: FontFamily.urbanistSemiBold,
                      fontSize: 16,
                      color: AppColors.primaryRedColor),
                ))
          ],
        ),
      );
}

class SortOrderDialogWidget extends StatelessWidget {
  const SortOrderDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Get.height * 0.4,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      color: Colors.transparent,
                      child: Assets.images.close.svg(height: 16, width: 16)),
                ),
              ),
              Text(
                "Sort_Order".tr,
                style: const TextStyle(
                  fontFamily: FontFamily.urbanistExtraBold,
                  fontSize: 26,
                ),
              ).paddingSymmetric(horizontal: 40),
              Divider(
                color: AppColors.borderColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) => const SizedBox(
                    height: 40,
                    child: Text(
                      "Grievance Id Ascending",
                      style: TextStyle(
                          fontFamily: FontFamily.urbanistMedium, fontSize: 16),
                    ),
                  ).paddingSymmetric(horizontal: 38),
                ),
              )
            ],
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget(
      {super.key, required this.title, this.error = false, this.onTap});

  final String title;
  final bool error;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 33),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error ? "Failed".tr : "Thank_You".tr,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistExtraBold, fontSize: 26),
              ),
              if (!error)
                const SizedBox(
                  height: 61,
                ),
              if (!error)
                Assets.images.checkmark
                    .image(color: AppColors.greenColor, height: 80, width: 80),
              const SizedBox(
                height: 37,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistRegular, fontSize: 16),
              ).paddingOnly(bottom: 60),
              CommonButton(
                text: "Close".tr,
                onTap: onTap ??
                    () {
                      Get.back();
                    },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ActionDialogWidget extends StatelessWidget {
  const ActionDialogWidget(
      {super.key, required this.grievanceModel, required this.permissions});

  final GDatum grievanceModel;
  final List<String> permissions;

  @override
  Widget build(BuildContext context) {
    GrievenceListController grievenceListController = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Get.height * 0.36,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Assets.images.close.svg(),
                ).paddingOnly(right: 19, top: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Action".tr,
                      style: const TextStyle(
                          fontFamily: FontFamily.urbanistExtraBold,
                          fontSize: 26),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: AppColors.borderColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          runSpacing: 12,
                          spacing: 12,
                          children: [
                            ActionCard(
                              cardColor: AppColors.firstActionColor,
                              text: "Respond".tr,
                              onTap: () {
                                Get.toNamed(RouteList.sendMessage,
                                        arguments: grievanceModel.idRequest)!
                                    .then((value) {
                                  Get.back();
                                });
                              },
                            ),
                            if (permissions.contains("ViewEmailHistory"))
                              ActionCard(
                                cardColor: AppColors.secondActionColor,
                                text: "Email_History".tr,
                                onTap: () {
                                  Get.toNamed(RouteList.grievanceEmailHistory,
                                          arguments: grievanceModel.idRequest)!
                                      .then((value) {
                                    Get.back();
                                  });
                                },
                              ),
                            if (permissions.contains("Transfer"))
                              ActionCard(
                                cardColor: AppColors.thirdActionColor,
                                text: "Transfer_Grievances".tr,
                                onTap: () {
                                  Get.toNamed(RouteList.transferGrievance,
                                          arguments: grievanceModel)!
                                      .then((value) {
                                    Get.back();
                                  });
                                },
                              ),
                            if (permissions.contains("UpdateStatus"))
                              ActionCard(
                                cardColor: AppColors.fourthActionColor,
                                text: "Update_Status".tr,
                                onTap: () {
                                  Get.toNamed(RouteList.changeGrievanceStatus,
                                          arguments: grievanceModel)!
                                      .then((value) {
                                    Get.back();
                                  });
                                },
                              ),
                            if (permissions.contains("ViewStatusHistory"))
                              ActionCard(
                                cardColor: AppColors.fifthActionColor,
                                text: "Status_History".tr,
                                onTap: () {
                                  Get.toNamed(RouteList.statusHistoryPage,
                                          arguments: grievanceModel)!
                                      .then((value) {
                                    Get.back();
                                  });
                                },
                              ),
                            if (permissions.contains("Edit"))
                              ActionCard(
                                cardColor: AppColors.sixthActionColor,
                                text: "Edit".tr,
                                onTap: () {
                                  Get.toNamed(RouteList.editGrievancePage,
                                          arguments: grievanceModel)!
                                      .then((value) {
                                    Get.back();
                                  });
                                },
                              ),
                            if (permissions.contains("view"))
                              ActionCard(
                                cardColor: AppColors.seventhActionColor,
                                text: "View".tr,
                                onTap: () {},
                              ),
                            if (permissions.contains("Delete"))
                              ActionCard(
                                cardColor: AppColors.eighthActionColor,
                                text: "Delete".tr,
                                onTap: () {
                                  DialogUtil.confirmationAlert(
                                    onConfirm: () async {
                                      Get.back();
                                      ApiClient apiClient = ApiClient();
                                      var deleteJson = await apiClient.post(
                                          path: ApiConst.wsDeleteGrievanceById,
                                          body: {
                                            ApiConst.grievanceId:
                                                grievanceModel.idRequest
                                          });
                                      if (deleteJson != null) {
                                        DeleteGrievanceModel
                                            deleteGrievanceModel =
                                            DeleteGrievanceModel.fromJson(
                                                deleteJson);
                                        if (deleteGrievanceModel.status ??
                                            false) {
                                          DialogUtil.customDialog(
                                              title: deleteGrievanceModel
                                                      .data!.message ??
                                                  "");
                                          grievenceListController
                                              .getGrievanceList();
                                        } else {
                                          DialogUtil.customDialog(
                                              title: "Failed".tr, error: true);
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ).paddingSymmetric(horizontal: 42),
              )
            ],
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard(
      {super.key,
      required this.cardColor,
      required this.text,
      required this.onTap});
  final Color cardColor;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: FontFamily.urbanistMedium, fontSize: 12),
        ).paddingSymmetric(vertical: 8, horizontal: 20),
      ),
    );
  }
}
