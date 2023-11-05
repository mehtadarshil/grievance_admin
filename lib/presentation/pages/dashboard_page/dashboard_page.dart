import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/models/department_graph_data_model.dart';
import 'package:grievance_admin/app/models/status_graph_data_model.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/controller/dashboard_controller.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/department_multi_page.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/department_multi_page_2.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/status_multi_page.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/status_multi_page_2.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/presentation/widgets/common_dropdown_widget.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: "Dashboard".tr,
      ),
      body: Column(
        children: [
          TabBar(
              labelColor: AppColors.blueTextColor,
              controller: controller.tabController,
              tabs: const [
                Tab(
                  text: "Status",
                ),
                Tab(
                  text: "Department",
                )
              ]),
          Expanded(
            child: TabBarView(controller: controller.tabController, children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () {
                        if (controller.selectedDepartmentIds.isNotEmpty) {
                          controller.departmentStatus.text =
                              "${controller.selectedDepartmentIds.length} selected";
                        } else {
                          controller.departmentStatus.text = "All";
                        }
                        return CommonTextField(
                            borderColor: AppColors.borderColor,
                            onTap: () {
                              Get.to(() => const DepartmentMultiPage());
                            },
                            hintText: ("Department".tr).replaceAll(":", ""),
                            title: ("Department".tr).replaceAll(":", ""),
                            controller: controller.departmentStatus);
                      },
                    ).paddingSymmetric(horizontal: 22, vertical: 11),
                    Obx(
                      () {
                        if (controller.selectedStatusIds.isNotEmpty) {
                          controller.statusStatus.text =
                              "${controller.selectedStatusIds.length} selected";
                        } else {
                          controller.statusStatus.text = "All";
                        }
                        return CommonTextField(
                            borderColor: AppColors.borderColor,
                            onTap: () {
                              Get.to(() => const StatusMultiPage());
                            },
                            hintText: ("Status".tr).replaceAll(":", ""),
                            title: ("Status".tr).replaceAll(":", ""),
                            controller: controller.statusStatus);
                      },
                    ).paddingSymmetric(
                      horizontal: 22,
                    ),
                    Obx(() => CommonDropdown(
                              data: controller.dropdownData,
                              title: "Sort_By_Date".tr,
                              value: controller.selectedDateTypeStatus.value,
                              onChange: (value) {
                                controller.selectedDateTypeStatus.value =
                                    value.toString();
                                controller.isValidCheck();
                              },
                            ))
                        .paddingOnly(bottom: 11, left: 22, right: 22, top: 11),
                    Obx(
                      () => Visibility(
                        visible:
                            controller.selectedDateTypeStatus.value == "custom",
                        child: CommonTextField(
                          hintText: "From".tr,
                          borderColor: AppColors.borderColor,
                          controller: controller.fromDateStatus,
                          title: "From".tr,
                          onTap: () async {
                            var fromDate =
                                await DialogUtil.showDatePickerDialog();
                            if (fromDate != null) {
                              controller.fromDateStatus.text =
                                  DateFormat("MM/dd/yyyy").format(fromDate);
                              controller.isValidCheck();
                            }
                          },
                        ).paddingOnly(bottom: 11, left: 22, right: 22),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible:
                            controller.selectedDateTypeStatus.value == "custom",
                        child: CommonTextField(
                          hintText: "To".tr,
                          borderColor: AppColors.borderColor,
                          controller: controller.toDateStatus,
                          title: "To".tr,
                          onTap: () async {
                            var toDate =
                                await DialogUtil.showDatePickerDialog();
                            if (toDate != null) {
                              controller.toDateStatus.text =
                                  DateFormat("MM/dd/yyyy").format(toDate);
                              controller.isValidCheck();
                            }
                          },
                        ).paddingOnly(left: 22, right: 22),
                      ),
                    ),
                    Obx(
                      () => Opacity(
                        opacity: controller.isValidStatus.value ? 1 : 0.5,
                        child: CommonButton(
                          text: "Search".tr,
                          onTap: controller.isValidStatus.value
                              ? () {
                                  controller.getStatusGraphData();
                                }
                              : () {},
                        ).paddingSymmetric(horizontal: 22, vertical: 10),
                      ),
                    ),
                    Obx(
                      () => controller.statusGraphDataModel.value == null
                          ? const Text("No Data Found").paddingOnly(top: 150)
                          : Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.borderColor, width: 1),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Get.width * 0.40,
                                    width: Get.width * 0.40,
                                    child: SfCircularChart(
                                      series: [
                                        PieSeries<DatumGraph, String>(
                                          dataSource: controller
                                              .statusGraphDataModel.value!.data,
                                          xValueMapper: (datum, index) =>
                                              datum.totalRequests.toString(),
                                          yValueMapper: (datum, index) =>
                                              int.parse(datum.totalRequests!),
                                          pointColorMapper: (datum, index) =>
                                              datum.color,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      for (var i = 0;
                                          i <
                                              controller.statusGraphDataModel
                                                  .value!.data!.length;
                                          i++)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            LimitedBox(
                                              maxWidth: Get.width * 0.4,
                                              child: Text(
                                                "${controller.statusGraphDataModel.value!.data![i].statusName} : ${controller.statusGraphDataModel.value!.data![i].totalRequests}",
                                                style: const TextStyle(),
                                                textAlign: TextAlign.end,
                                              ).paddingOnly(right: 12),
                                            ),
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        controller
                                                            .statusGraphDataModel
                                                            .value!
                                                            .data![i]
                                                            .color!
                                                            .red,
                                                        controller
                                                            .statusGraphDataModel
                                                            .value!
                                                            .data![i]
                                                            .color!
                                                            .green,
                                                        controller
                                                            .statusGraphDataModel
                                                            .value!
                                                            .data![i]
                                                            .color!
                                                            .blue,
                                                        1),
                                                    width: 2),
                                              ),
                                            ),
                                          ],
                                        ).paddingOnly(bottom: 10)
                                    ],
                                  ).paddingOnly(right: 14))
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 20, vertical: 22),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () {
                        if (controller
                            .selectedDepartmentIdsDepartment.isNotEmpty) {
                          controller.departmentDepartment.text =
                              "${controller.selectedDepartmentIdsDepartment.length} selected";
                        } else {
                          controller.departmentDepartment.text = "All";
                        }
                        return CommonTextField(
                            borderColor: AppColors.borderColor,
                            onTap: () {
                              Get.to(() => const DepartmentMultiPage2());
                            },
                            hintText: ("Department".tr).replaceAll(":", ""),
                            title: ("Department".tr).replaceAll(":", ""),
                            controller: controller.departmentDepartment);
                      },
                    ).paddingSymmetric(horizontal: 22, vertical: 11),
                    Obx(
                      () {
                        if (controller.selectedStatusIdsDepartment.isNotEmpty) {
                          controller.statusDepartment.text =
                              "${controller.selectedStatusIdsDepartment.length} selected";
                        } else {
                          controller.statusDepartment.text = "All";
                        }
                        return CommonTextField(
                            borderColor: AppColors.borderColor,
                            onTap: () {
                              Get.to(() => const StatusMultiPage2());
                            },
                            hintText: ("Status".tr).replaceAll(":", ""),
                            title: ("Status".tr).replaceAll(":", ""),
                            controller: controller.statusDepartment);
                      },
                    ).paddingSymmetric(
                      horizontal: 22,
                    ),
                    Obx(() => CommonDropdown(
                              data: controller.dropdownData,
                              title: "Sort_By_Date".tr,
                              value:
                                  controller.selectedDateTypeDepartment.value,
                              onChange: (value) {
                                controller.selectedDateTypeDepartment.value =
                                    value.toString();
                                controller.isValidCheck2();
                              },
                            ))
                        .paddingOnly(bottom: 11, left: 22, right: 22, top: 11),
                    Obx(
                      () => Visibility(
                        visible: controller.selectedDateTypeDepartment.value ==
                            "custom",
                        child: CommonTextField(
                          hintText: "From".tr,
                          borderColor: AppColors.borderColor,
                          controller: controller.fromDateDepartment,
                          title: "From".tr,
                          onTap: () async {
                            var fromDate =
                                await DialogUtil.showDatePickerDialog();
                            if (fromDate != null) {
                              controller.fromDateDepartment.text =
                                  DateFormat("MM/dd/yyyy").format(fromDate);
                              controller.isValidCheck2();
                            }
                          },
                        ).paddingOnly(bottom: 11, left: 22, right: 22),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.selectedDateTypeDepartment.value ==
                            "custom",
                        child: CommonTextField(
                          hintText: "To".tr,
                          borderColor: AppColors.borderColor,
                          controller: controller.toDateDepartment,
                          title: "To".tr,
                          onTap: () async {
                            var toDate =
                                await DialogUtil.showDatePickerDialog();
                            if (toDate != null) {
                              controller.toDateDepartment.text =
                                  DateFormat("MM/dd/yyyy").format(toDate);
                              controller.isValidCheck2();
                            }
                          },
                        ).paddingOnly(left: 22, right: 22),
                      ),
                    ),
                    Obx(
                      () => Opacity(
                        opacity: controller.isValidDepartment.value ? 1 : 0.5,
                        child: CommonButton(
                          text: "Search".tr,
                          onTap: controller.isValidDepartment.value
                              ? () {
                                  controller.getDepartmentGraphData();
                                }
                              : () {},
                        ).paddingSymmetric(horizontal: 22, vertical: 10),
                      ),
                    ),
                    Obx(
                      () => controller.departmentGraphDataModel.value == null
                          ? const Text("No Data Found").paddingOnly(top: 150)
                          : Container(
                              padding: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.borderColor, width: 1),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Get.width * 0.4,
                                    width: Get.width * 0.4,
                                    child: SfCircularChart(
                                      series: [
                                        PieSeries<DepartmentDatum, String>(
                                          dataSource: controller
                                              .departmentGraphDataModel
                                              .value!
                                              .data,
                                          xValueMapper: (datum, index) =>
                                              datum.totalRequests.toString(),
                                          yValueMapper: (datum, index) =>
                                              int.parse(datum.totalRequests!),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      for (var i = 0;
                                          i <
                                              controller
                                                  .departmentGraphDataModel
                                                  .value!
                                                  .data!
                                                  .length;
                                          i++)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            LimitedBox(
                                              maxWidth: Get.width * 0.4,
                                              child: Text(
                                                "${controller.departmentGraphDataModel.value!.data![i].departmentName} : ${controller.departmentGraphDataModel.value!.data![i].totalRequests}",
                                                style: const TextStyle(),
                                                textAlign: TextAlign.end,
                                              ).paddingOnly(right: 12),
                                            ),
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        controller
                                                            .departmentGraphDataModel
                                                            .value!
                                                            .data![i]
                                                            .color!
                                                            .red,
                                                        controller
                                                            .departmentGraphDataModel
                                                            .value!
                                                            .data![i]
                                                            .color!
                                                            .green,
                                                        controller
                                                            .departmentGraphDataModel
                                                            .value!
                                                            .data![i]
                                                            .color!
                                                            .blue,
                                                        1),
                                                    width: 2),
                                              ),
                                            ),
                                          ],
                                        ).paddingOnly(bottom: 10)
                                    ],
                                  ).paddingOnly(right: 14))
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 20, vertical: 22),
                    ),
                  ],
                ),
              ),
            ]),
          )
          // Expanded(
          //   child: LineChart(LineChartData(
          //     gridData: FlGridData(
          //       show: true,
          //       drawVerticalLine: true,
          //       horizontalInterval: 1,
          //       verticalInterval: 1,
          //       getDrawingHorizontalLine: (value) {
          //         return FlLine(
          //           color: AppColors.primaryBlueColor,
          //           strokeWidth: 1,
          //         );
          //       },
          //       getDrawingVerticalLine: (value) {
          //         return FlLine(
          //           color: AppColors.primaryBlueColor,
          //           strokeWidth: 1,
          //         );
          //       },
          //     ),
          //     titlesData: FlTitlesData(
          //       show: true,
          //       rightTitles: AxisTitles(
          //         sideTitles: SideTitles(showTitles: false),
          //       ),
          //       topTitles: AxisTitles(
          //         sideTitles: SideTitles(showTitles: false),
          //       ),
          //       bottomTitles: AxisTitles(
          //         sideTitles: SideTitles(
          //           showTitles: true,
          //           reservedSize: 30,
          //           interval: 1,
          //           getTitlesWidget: (value, meta) => Text(value.toString()),
          //         ),
          //       ),
          //       leftTitles: AxisTitles(
          //         sideTitles: SideTitles(
          //           showTitles: true,
          //           interval: 1,
          //           getTitlesWidget: (value, meta) => Text(value.toString()),
          //           reservedSize: 42,
          //         ),
          //       ),
          //     ),
          //     borderData: FlBorderData(
          //       show: true,
          //       border: Border.all(color: const Color(0xff37434d)),
          //     ),
          //     minX: 0,
          //     maxX: 20,
          //     minY: 0,
          //     maxY: 500000,
          //     lineBarsData: [
          //       LineChartBarData(
          //         spots: const [
          //           FlSpot(5, 325000),
          //           FlSpot(10, 200000),
          //           FlSpot(15, 400000),
          //           FlSpot(20, 225000),
          //         ],
          //         isCurved: true,
          //         gradient: LinearGradient(
          //           colors: [AppColors.primaryBlueColor, Colors.transparent],
          //         ),
          //         barWidth: 5,
          //         isStrokeCapRound: true,
          //         dotData: FlDotData(
          //           show: false,
          //         ),
          //         belowBarData: BarAreaData(
          //           show: true,
          //           gradient: LinearGradient(
          //             colors: [AppColors.primaryBlueColor, Colors.transparent]
          //                 .map((color) => color.withOpacity(0.3))
          //                 .toList(),
          //           ),
          //         ),
          //       ),
          //     ],
          //   )),
          // )
        ],
      ),
    );
  }
}

class TempData {
  final String title;
  final int value;

  TempData(this.title, this.value);
}
