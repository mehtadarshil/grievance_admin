import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/di/app_base_component.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/full_screen_image_viewer.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_rowtext_field.dart';
import 'package:grievance_admin/presentation/widgets/common_table_button.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/presentation/widgets/filter_card_widget.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:grievance_admin/utils/logger.dart';
import 'package:intl/intl.dart';
import 'package:simple_html_css/simple_html_css.dart';

class GrievenceListPage extends GetView<GrievenceListController> {
  const GrievenceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppbar(
        title: "grievence_list".tr,
        splitTitle: true,
        actions: [
          GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteList.reportPage);
                  },
                  child: const Icon(Icons.text_snippet_outlined))
              .paddingOnly(right: 5),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteList.alertPageScreen);
            },
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.notifications_outlined)),
                  Positioned(
                    right: 3,
                    top: 18,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.whiteColor, width: 1),
                          color: AppColors.primaryRedColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ).paddingOnly(right: 5),
          GestureDetector(
                  onTap: () {
                    DialogUtil.confirmationAlert(
                      title: "log_out_title".tr,
                      onConfirm: () async {
                        await GetStorage().write(DbKeys.userData, null);
                        Get.offAllNamed(RouteList.signInPage);
                      },
                    );
                  },
                  child: const Icon(Icons.logout_rounded))
              .paddingOnly(right: 5),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.getGrievanceList();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            // This callback will be triggered when overscrolling occurs
            if (overscroll.leading) {
              // leading edge overscroll (top on iOS, left on Android)
              Logger.prints('Top overscroll');
            } else {
              if (!AppComponentBase.instance.loading) {
                controller.pageNo = (controller.pageNo + 1);
                controller.getGrievanceList();
                controller.loadCount();
              }
            }
            return true; // Return true to prevent the indicator from showing
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 27,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: "Search".tr,
                        controller: controller.searchController,
                        borderColor: AppColors.borderColor,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteList.grievanceFilterPage);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Assets.images.icFilter.svg(),
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: 20),
                // const SizedBox(
                //   height: 9,
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "Add_New_Grievances".tr,
                //     style: TextStyle(
                //         color: AppColors.blueTextColor,
                //         fontSize: 12,
                //         fontFamily: FontFamily.urbanistMedium),
                //   ),
                // ).paddingSymmetric(horizontal: 20),
                const SizedBox(
                  height: 38,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.filterCardData
                      .map((e) => Obx(() => GestureDetector(
                            onTap: () {
                              controller.selectedFilterCard.value = e.value;
                              controller.grievanceDetails.clear();
                              controller.pageNo = 1;
                              controller.getGrievanceList();
                            },
                            child: FilterCardWidget(
                                title: e.title,
                                count: controller.allTabCount.value == null
                                    ? 0
                                    : (e.title == "Grievance"
                                        ? controller.allTabCount.value!.data!
                                            .grievances!
                                        : e.title == "Pending"
                                            ? controller.allTabCount.value!
                                                .data!.pendencyGrievances!
                                            : e.title == "Transferred"
                                                ? controller
                                                    .allTabCount
                                                    .value!
                                                    .data!
                                                    .transferredGrievances!
                                                : e.title ==
                                                        "Unassigned Grievances"
                                                    ? controller
                                                        .allTabCount
                                                        .value!
                                                        .data!
                                                        .unassignedGrievances!
                                                    : e.title ==
                                                            "Resoved/Closed"
                                                        ? controller
                                                            .allTabCount
                                                            .value!
                                                            .data!
                                                            .closedResolvedGrievances!
                                                        : 0),
                                selected: controller.selectedFilterCard.value ==
                                    e.value),
                          )))
                      .toList(),
                ),
                const SizedBox(
                  height: 38,
                ),
                Obx(
                  () {
                    if (controller.grievanceDetails.isNotEmpty) {
                      List<DataRow> data = [];
                      for (var i = 0;
                          i < controller.grievanceDetails.length;
                          i++) {
                        var detail = controller.grievanceDetails[i];
                        data.add(DataRow(cells: [
                          DataCell(Column(
                            children: [
                              Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                    color:
                                        AppColors.textColor.withOpacity(0.5)),
                              ),
                            ],
                          ).paddingSymmetric(vertical: 10)),
                          DataCell(SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CommonRowTextField(
                                    title: "Gievance_Id".tr,
                                    value: detail.idRequest ?? ""),
                                CommonRowTextField(
                                    title: "Customer_name".tr,
                                    value: detail.customerName ?? ""),
                                CommonRowTextField(
                                    title: "Address".tr,
                                    value: detail.address ?? ""),
                                CommonRowTextField(
                                    title: "Date_Created".tr,
                                    value: DateFormat("dd MMM,yyyy")
                                        .format(detail.createdOn!)),
                                CommonRowTextField(
                                    title: "Department".tr,
                                    value: detail.department ?? ""),
                              ],
                            ).paddingSymmetric(vertical: 10),
                          )),
                          DataCell(SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (detail.requestFileArray!.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => FullScreenImageViewer(
                                          url: detail.requestFileArray!.first
                                              .requestImagePath!
                                              .replaceAll(" ", "")));
                                    },
                                    child: Image.network(
                                      detail.requestFileArray!.first
                                          .requestImagePath!
                                          .replaceAll(" ", ""),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Text("Failed to Load"),
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                Text.rich(TextSpan(children: [
                                  HTML.toTextSpan(context, detail.remarks ?? "",
                                      defaultTextStyle: TextStyle(
                                          fontFamily: FontFamily.urbanistMedium,
                                          fontSize: 14,
                                          color: AppColors.color999999)),
                                  TextSpan(
                                      text: "Remark".tr,
                                      style: TextStyle(
                                          fontFamily: FontFamily.urbanistMedium,
                                          fontSize: 14,
                                          color: AppColors.blueTextColor))
                                ])),
                                CommonRowTextField(
                                    title: "Requested_By".tr,
                                    value: detail.requestInitiatedBy ?? ""),
                                CommonRowTextField(
                                    title: "Date_Created".tr,
                                    value: DateFormat("dd MMM,yyyy")
                                        .format(detail.createdOn!))
                              ],
                            ).paddingSymmetric(vertical: 10),
                          )),
                          DataCell(SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CommonTableButton(
                                          text: "View_Grievances_Updates".tr,
                                          onTap: () {
                                            Get.toNamed(
                                                RouteList.statusHistoryPage,
                                                arguments: detail);
                                          },
                                        ).paddingOnly(bottom: 10, top: 10),
                                        for (var i = 0;
                                            i <
                                                detail
                                                    .requestStatusArray!.length;
                                            i++)
                                          ListTileTheme(
                                            data: const ListTileThemeData(
                                                dense: true,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                horizontalTitleGap: 0,
                                                minVerticalPadding: 0,
                                                minLeadingWidth: 0,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8)),
                                            child: ExpansionTile(
                                              textColor: AppColors.textColor,
                                              iconColor: AppColors.blackColor,
                                              backgroundColor:
                                                  AppColors.bgColor,
                                              collapsedBackgroundColor:
                                                  AppColors.bgColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text: "Status".tr,
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
                                                                .urbanistBold,
                                                            fontSize: 12)),
                                                    TextSpan(
                                                        text: detail
                                                                .requestStatusArray![
                                                                    i]
                                                                .status ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
                                                                .urbanistMedium,
                                                            fontSize: 12))
                                                  ])),
                                                ],
                                              ),
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          AppColors.whiteColor),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"Date".tr}: ",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: DateFormat(
                                                                    "dd MMM,yyyy")
                                                                .format(detail
                                                                    .requestStatusArray![
                                                                        i]
                                                                    .createdOn!),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                fontSize: 12))
                                                      ])),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"Assign_to".tr}: ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: detail
                                                                    .requestStatusArray![
                                                                        i]
                                                                    .grievanceAssignedTo ??
                                                                "",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12))
                                                      ])),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"Assign_On".tr}: ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: detail
                                                                    .requestStatusArray![
                                                                        i]
                                                                    .grievanceAssignedDate ??
                                                                "",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12))
                                                      ])),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"Assigned_Details".tr}: ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: detail
                                                                    .requestStatusArray![
                                                                        i]
                                                                    .grievanceAssignDetails ??
                                                                "",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12))
                                                      ]))
                                                    ],
                                                  ).paddingAll(5),
                                                )
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 5)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                          DataCell(SizedBox(
                            width: 170,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CommonTableButton(
                                          text: "View_Email_History".tr,
                                          onTap: () {
                                            Get.toNamed(
                                                RouteList.grievanceEmailHistory,
                                                arguments: detail.idRequest);
                                          },
                                        ).paddingSymmetric(vertical: 10),
                                        for (var i = 0;
                                            i <
                                                detail.requestEmailstatusArray!
                                                    .length;
                                            i++)
                                          ListTileTheme(
                                            data: const ListTileThemeData(
                                                dense: true,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                horizontalTitleGap: 0,
                                                minVerticalPadding: 0,
                                                minLeadingWidth: 0,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8)),
                                            child: ExpansionTile(
                                              textColor: AppColors.textColor,
                                              iconColor: AppColors.blackColor,
                                              backgroundColor:
                                                  AppColors.bgColor,
                                              collapsedBackgroundColor:
                                                  AppColors.bgColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text: detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .sendBy ==
                                                                "User"
                                                            ? "${"From_Customer".tr}: "
                                                            : "${"From_Internal_User".tr}: ",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
                                                                .urbanistBold,
                                                            fontSize: 12)),
                                                  ])),
                                                ],
                                              ),
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          AppColors.whiteColor),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text: detail
                                                                        .requestEmailstatusArray![
                                                                            i]
                                                                        .sendBy ==
                                                                    "User"
                                                                ? "${"From_Customer".tr}: "
                                                                : "${"From_Internal_User".tr}: ",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: detail
                                                                        .requestEmailstatusArray![
                                                                            i]
                                                                        .sendBy ==
                                                                    "User"
                                                                ? detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .customerFirstName
                                                                : detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .firstName,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                fontSize: 12))
                                                      ])),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text: detail
                                                                        .requestEmailstatusArray![
                                                                            i]
                                                                        .sendBy ==
                                                                    "User"
                                                                ? "${"To_Internal_User".tr}: "
                                                                : "${"To_Customer".tr}: ",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: detail
                                                                        .requestEmailstatusArray![
                                                                            i]
                                                                        .sendBy ==
                                                                    "User"
                                                                ? detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .firstName
                                                                : detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .customerFirstName,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                fontSize: 12))
                                                      ])),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"Date".tr}: ",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: DateFormat(
                                                                    "dd MMM,yyyy hh:mm:aa")
                                                                .format(detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .createdOn!),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                fontSize: 12))
                                                      ])),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"Subject".tr}: ",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistBold,
                                                                fontSize: 12)),
                                                        TextSpan(
                                                            text: detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .subject ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                fontSize: 12))
                                                      ]))
                                                    ],
                                                  ).paddingAll(5),
                                                )
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 5)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                          DataCell(GestureDetector(
                            onTap: () {
                              DialogUtil.actionDialog(
                                  grievanceModel: detail,
                                  permissions: controller.permissions);
                            },
                            child: Container(
                              color: Colors.transparent,
                              margin: const EdgeInsets.all(10),
                              width: 18,
                              height: 18,
                              child: Assets.images.actionIcon.svg(),
                            ),
                          )),
                        ]));
                      }
                      return SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              headingRowHeight: 29,
                              dataRowHeight: 200,
                              columnSpacing: 20,
                              headingRowColor: MaterialStatePropertyAll(
                                  AppColors.headerColor),
                              columns: [
                                DataColumn(
                                    label: Text(
                                  "Si".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Grievance_Details".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Description".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Status_Updates".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Message_Updates".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Action".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 14,
                                  ),
                                )),
                              ],
                              rows: data),
                        ),
                      );
                    } else {
                      return const Text(
                        "No Data Found",
                        style: TextStyle(
                            fontFamily: FontFamily.urbanistSemiBold,
                            fontSize: 18),
                      ).paddingOnly(top: 150);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
