import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/alert_page/controller/alert_page_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:intl/intl.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AlertPageScreen extends GetView<AlertPageController> {
  const AlertPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: "Alert".tr,
        actions: const [
          // ButtonBar(children: [
          //   GestureDetector(
          //     onTap: () {
          //       DialogUtil.sortOrderDialog();
          //     },
          //     child: Container(
          //       height: 32,
          //       width: 32,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         color: AppColors.bgColor,
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Assets.images.icFilter.svg(width: 12.31, height: 13.54),
          //     ),
          //   ),
          // ])
        ],
      ),
      body: Column(
        children: [
          TabBar(
            labelColor: AppColors.blueTextColor,
            tabs: const [
              Tab(
                text: "Status",
              ),
              Tab(
                text: "Email",
              )
            ],
            controller: controller.tabController,
          ),
          Expanded(
              child:
                  TabBarView(controller: controller.tabController, children: [
            Column(
              children: [
                Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.colorFFF9F0,
                      border: Border(
                          left: BorderSide(
                              width: 5, color: AppColors.colorEDA32E))),
                  child: Obx(
                    () => Text(
                      "You have ${controller.alertData.value?.data?.statusNotifications?.length ?? 0} new status update(s).",
                      style: TextStyle(
                          fontFamily: FontFamily.urbanistMedium,
                          fontSize: 16,
                          color: AppColors.colorEDA32E),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 20, vertical: 30),
                Expanded(
                  child: Obx(
                    () => controller.alertData.value == null
                        ? const SizedBox.shrink()
                        : ListView.separated(
                            itemCount: controller.alertData.value!.data!
                                .statusNotifications!.length,
                            itemBuilder: (context, index) {
                              var data = controller.alertData.value!.data!
                                  .statusNotifications![index];

                              return Container(
                                color: AppColors.whiteColor,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 38,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.colorE6F3FF),
                                      child: Text(
                                        "G",
                                        style: TextStyle(
                                            color: AppColors.primaryBlueColor,
                                            fontFamily: FontFamily.urbanistBold,
                                            fontSize: 20),
                                      ),
                                    ).paddingOnly(left: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data.customerName} ${data.uniqueRequestId} with status “${data.status}” has been updated by on",
                                            style: TextStyle(
                                                color: AppColors.textColor
                                                    .withOpacity(0.5),
                                                fontSize: 16,
                                                height: 1.5,
                                                fontFamily:
                                                    FontFamily.urbanistMedium),
                                          ),
                                          Text(
                                            DateFormat("dd MMM,yyyy hh:mm:aa")
                                                .format(data.updatedOn!),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                fontFamily:
                                                    FontFamily.urbanistMedium),
                                          )
                                        ],
                                      ).paddingSymmetric(
                                          vertical: 30, horizontal: 14),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 1,
                                color: AppColors.borderColor,
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.colorFFF9F0,
                      border: Border(
                          left: BorderSide(
                              width: 5, color: AppColors.colorEDA32E))),
                  child: Obx(
                    () => Text(
                      "You have ${controller.alertData.value?.data?.responseNotifications?.length ?? 0} new email update(s).",
                      style: TextStyle(
                          fontFamily: FontFamily.urbanistMedium,
                          fontSize: 16,
                          color: AppColors.colorEDA32E),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 20, vertical: 30),
                Expanded(
                  child: Obx(
                    () => controller.alertData.value == null
                        ? const SizedBox.shrink()
                        : ListView.separated(
                            itemCount: controller.alertData.value!.data!
                                .responseNotifications!.length,
                            itemBuilder: (context, index) {
                              var data = controller.alertData.value!.data!
                                  .responseNotifications![index];
                              return Container(
                                color: AppColors.whiteColor,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 38,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.colorE6F3FF),
                                      child: Text(
                                        "G",
                                        style: TextStyle(
                                            color: AppColors.primaryBlueColor,
                                            fontFamily: FontFamily.urbanistBold,
                                            fontSize: 20),
                                      ),
                                    ).paddingOnly(left: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  "${data.customerFirstName} ${data.uniqueRequestId} with subject “${data.subject}” has Message ",
                                              style: TextStyle(
                                                  color: AppColors.textColor
                                                      .withOpacity(0.5),
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  fontFamily: FontFamily
                                                      .urbanistMedium),
                                            ),
                                            HTML.toTextSpan(
                                                context,
                                                (data.emailStatusRemarks ?? "")
                                                    .replaceAll(r"\r\n", ""),
                                                defaultTextStyle: TextStyle(
                                                    color: AppColors.textColor
                                                        .withOpacity(0.5),
                                                    fontSize: 16,
                                                    height: 1.5,
                                                    fontFamily: FontFamily
                                                        .urbanistMedium)),
                                            TextSpan(
                                              text: " on",
                                              style: TextStyle(
                                                  color: AppColors.textColor
                                                      .withOpacity(0.5),
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  fontFamily: FontFamily
                                                      .urbanistMedium),
                                            ),
                                          ])),
                                          Text(
                                            DateFormat("dd MMM,yyyy hh:mm:aa")
                                                .format(data.updatedOn!),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                fontFamily:
                                                    FontFamily.urbanistMedium),
                                          )
                                        ],
                                      ).paddingSymmetric(
                                          vertical: 30, horizontal: 14),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 1,
                                color: AppColors.borderColor,
                              );
                            },
                          ),
                  ),
                )
              ],
            )
          ])),
        ],
      ),
    );
  }
}
