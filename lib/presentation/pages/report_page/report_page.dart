import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/report_page/controller/report_controller.dart';
import 'package:grievance_admin/presentation/pages/report_page/report_fiilter_page.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/filter_card_widget.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class ReportPage extends GetView<ReportController> {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: "Reports".tr,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const ReportFilterPage());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Assets.images.icFilter.svg(),
                ).paddingOnly(right: 7),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: controller.filterCardData
                .map((e) => Obx(() => GestureDetector(
                      onTap: () {
                        controller.selectedFilterCard.value = e.value;
                      },
                      child: FilterCardWidget(
                          title: e.title,
                          count: controller.reportCount.value == null
                              ? 0
                              : (e.title == "Grievance"
                                  ? controller
                                      .reportCount.value!.data!.totalGrievances!
                                  : e.title == "Resolved"
                                      ? controller.reportCount.value!.data!
                                          .resolvedGrievances!
                                      : e.title == "Pending"
                                          ? controller.reportCount.value!.data!
                                              .pendingGrievances!
                                          : e.title == "Transffered Grievances"
                                              ? controller.reportCount.value!
                                                  .data!.transferredGrievances!
                                              : e.title == "Immediate Action"
                                                  ? controller
                                                      .reportCount
                                                      .value!
                                                      .data!
                                                      .immediateGrievances!
                                                  : e.title == "Medium Term"
                                                      ? controller
                                                          .reportCount
                                                          .value!
                                                          .data!
                                                          .mediumTermGrievances!
                                                      : e.title == "Long Term"
                                                          ? controller
                                                              .reportCount
                                                              .value!
                                                              .data!
                                                              .longTermGrievances!
                                                          : 0),
                          selected:
                              controller.selectedFilterCard.value == e.value),
                    )))
                .toList(),
          ).paddingSymmetric(vertical: 20),
          Expanded(
            child: Obx(
              () {
                if (controller.reportData.value != null) {
                  List<DataRow> dataRows = [];

                  for (var i = 0;
                      i < controller.reportData.value!.data!.length;
                      i++) {
                    var data = controller.reportData.value!.data![i];
                    dataRows.add(DataRow(cells: [
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
                      DataCell(Column(
                        children: [
                          Text(
                            (data.departmentName).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalGrievances).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalResolved).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalPending).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalImmediateAction).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalMediumTerm).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalLongTerm).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalTransferred).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10)),
                      DataCell(Column(
                        children: [
                          Text(
                            (data.totalNotResponded).toString(),
                            style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                                color: AppColors.textColor.withOpacity(0.5)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10))
                    ]));
                  }
                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          headingRowHeight: 29,
                          dataRowHeight: 50,
                          columnSpacing: 20,
                          headingRowColor:
                              MaterialStatePropertyAll(AppColors.headerColor),
                          columns: const [
                            DataColumn(
                                label: Text(
                              "Si",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Department",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Total Grievance",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Resolved",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Pending",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Immediate Action",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Medium Term",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Long Term",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Transferred",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Not Responded",
                              style: TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 14,
                              ),
                            ))
                          ],
                          rows: dataRows),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
