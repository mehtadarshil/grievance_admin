import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/status_history_page/controller/status_history_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:intl/intl.dart';

class StatusHistoryPage extends GetView<StatusHistoryController> {
  const StatusHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      extendBody: true,
      appBar: CommonAppbar(title: "Status_History".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Request_Id".tr,
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
                    "Customer_Name".tr,
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
                      controller.grievanceModel.customerName ?? "",
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
                    "${"Description".tr}:",
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
                      controller.grievanceModel.remarks ?? "",
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
            Align(
              alignment: Alignment.center,
              child: Text(
                "Status_History".tr,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistBold, fontSize: 22),
              ),
            ).paddingOnly(top: 35, bottom: 24),
            Obx(
              () => controller.statusHistory.value == null
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 27, vertical: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = controller.statusHistory.value!.data![index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(19),
                              decoration: BoxDecoration(
                                  color: AppColors.cardBgColor,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(5))),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Status".tr,
                                    style: TextStyle(
                                        fontFamily: FontFamily.urbanistBold,
                                        fontSize: 14,
                                        color: AppColors.textColor)),
                                TextSpan(
                                    text: data.status ?? "",
                                    style: TextStyle(
                                        fontFamily: FontFamily.urbanistMedium,
                                        fontSize: 14,
                                        color: AppColors.textColor))
                              ])),
                            ),
                            Container(
                              padding: const EdgeInsets.all(1.2),
                              decoration: BoxDecoration(
                                  color: AppColors.cardBgColor,
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(5))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(19),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "UPDATED_BY".tr,
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistBold,
                                              fontSize: 14,
                                              color: AppColors.textColor)),
                                      TextSpan(
                                          text: data.firstName ?? "",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistMedium,
                                              fontSize: 14,
                                              color: AppColors.textColor))
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "UPDATED_ON".tr,
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistBold,
                                              fontSize: 14,
                                              color: AppColors.textColor)),
                                      TextSpan(
                                          text:
                                              DateFormat("dd MMM,yyyy hh:mm:aa")
                                                  .format(data.createdOn!),
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistMedium,
                                              fontSize: 14,
                                              color: AppColors.textColor))
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "NOTIFICATION".tr,
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistBold,
                                              fontSize: 14,
                                              color: AppColors.textColor)),
                                      TextSpan(
                                          text: data.notification ?? "",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistMedium,
                                              fontSize: 14,
                                              color: AppColors.textColor))
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "REMARKS".tr,
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistBold,
                                              fontSize: 14,
                                              color: AppColors.textColor)),
                                      TextSpan(
                                          text: data.remarks ?? "",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.urbanistMedium,
                                              fontSize: 14,
                                              color: AppColors.textColor))
                                    ])),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      itemCount: controller.statusHistory.value!.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
