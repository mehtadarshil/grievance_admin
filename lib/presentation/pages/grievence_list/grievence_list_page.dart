import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_rowtext_field.dart';
import 'package:grievance_admin/presentation/widgets/common_table_button.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
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
        onLeadingTap: () {},
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteList.alertPageScreen);
            },
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
          )
        ],
      ),
      body: SingleChildScrollView(
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
            const SizedBox(
              height: 9,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Add_New_Grievances".tr,
                style: TextStyle(
                    color: AppColors.blueTextColor,
                    fontSize: 12,
                    fontFamily: FontFamily.urbanistMedium),
              ),
            ).paddingSymmetric(horizontal: 20),
            const SizedBox(
              height: 38,
            ),
            Obx(
              () {
                if (controller.grievanceDetails.value != null) {
                  List<DataRow> data = [];
                  for (var i = 0;
                      i < controller.grievanceDetails.value!.data!.length;
                      i++) {
                    var detail = controller.grievanceDetails.value!.data![i];
                    data.add(DataRow(cells: [
                      DataCell(Column(
                        children: [
                          Text(
                            (i + 1).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
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
                                      onTap: () {},
                                    ).paddingOnly(bottom: 10, top: 10),
                                    for (var i = 0;
                                        i < detail.requestStatusArray!.length;
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
                                          backgroundColor: AppColors.bgColor,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.whiteColor),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text: "${"Date".tr}: ",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
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
                                                            fontFamily: FontFamily
                                                                .urbanistMedium,
                                                            fontSize: 12))
                                                  ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "${"Assign_to".tr}: ",
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
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
                                                        style:
                                                            TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12))
                                                  ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "${"Assign_On".tr}: ",
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
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
                                                        style:
                                                            TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .urbanistMedium,
                                                                color: AppColors
                                                                    .redColor,
                                                                fontSize: 12))
                                                  ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "${"Assigned_Details".tr}: ",
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
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
                                                        style:
                                                            TextStyle(
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
                                          backgroundColor: AppColors.bgColor,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.whiteColor),
                                              child: Column(
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
                                                            fontFamily: FontFamily
                                                                .urbanistMedium,
                                                            fontSize: 12))
                                                  ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text: detail
                                                                    .requestEmailstatusArray![
                                                                        i]
                                                                    .sendBy ==
                                                                "User"
                                                            ? "${"To_Internal_User".tr}: "
                                                            : "${"To_Customer".tr}: ",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
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
                                                            fontFamily: FontFamily
                                                                .urbanistMedium,
                                                            fontSize: 12))
                                                  ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text: "${"Date".tr}: ",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
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
                                                            fontFamily: FontFamily
                                                                .urbanistMedium,
                                                            fontSize: 12))
                                                  ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "${"Subject".tr}: ",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
                                                                .urbanistBold,
                                                            fontSize: 12)),
                                                    TextSpan(
                                                        text: detail
                                                                .requestEmailstatusArray![
                                                                    i]
                                                                .subject ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontFamily: FontFamily
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
                          DialogUtil.actionDialog(grievanceModel: detail);
                        },
                        child: Container(
                          color: Colors.transparent,
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
                          headingRowColor:
                              MaterialStatePropertyAll(AppColors.headerColor),
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
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
