import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class DialogUtil {
  static void actionDialog({required GDatum grievanceModel}) => showDialog(
        context: Get.context!,
        builder: (context) => ActionDialogWidget(
          grievanceModel: grievanceModel,
        ),
      );

  static void customDialog({required String title, bool? error}) {
    showDialog(
      context: Get.context!,
      builder: (context) => CustomDialogWidget(
        title: title,
        error: error ?? false,
      ),
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget(
      {super.key, required this.title, this.error = false});

  final String title;
  final bool error;

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
                onTap: () {
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
  const ActionDialogWidget({super.key, required this.grievanceModel});

  final GDatum grievanceModel;

  @override
  Widget build(BuildContext context) {
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
                            ActionCard(
                              cardColor: AppColors.fifthActionColor,
                              text: "Status_History".tr,
                              onTap: () {},
                            ),
                            ActionCard(
                              cardColor: AppColors.sixthActionColor,
                              text: "Edit".tr,
                              onTap: () {},
                            ),
                            ActionCard(
                              cardColor: AppColors.seventhActionColor,
                              text: "View".tr,
                              onTap: () {},
                            ),
                            ActionCard(
                              cardColor: AppColors.eighthActionColor,
                              text: "Delete".tr,
                              onTap: () {},
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
