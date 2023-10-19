import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: "Dashboard".tr,
        onLeadingTap: () {},
      ),
      body: GestureDetector(
        onTap: () {
          Get.toNamed(RouteList.grievenceList);
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  SizedBox(
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    child: SfCircularChart(
                      series: [
                        PieSeries<int, String>(
                          dataSource: [20, 25, 30, 45],
                          xValueMapper: (datum, index) => datum.toString(),
                          yValueMapper: (datum, index) => datum,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Not_addressed".tr}20")
                              .paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.color7F68FA, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Pending".tr}20").paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.colorFFA550, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Resolved".tr}20").paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.colorEA6061, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Discarded".tr}20").paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.color638EFA, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                    ],
                  ).paddingOnly(right: 14))
                ],
              ),
            ).paddingSymmetric(horizontal: 20, vertical: 22),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  SizedBox(
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    child: SfCircularChart(
                      series: [
                        PieSeries<int, String>(
                          dataSource: [20, 25, 30, 45],
                          xValueMapper: (datum, index) => datum.toString(),
                          yValueMapper: (datum, index) => datum,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Not_addressed".tr}20")
                              .paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.color7F68FA, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Pending".tr}20").paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.colorFFA550, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Resolved".tr}20").paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.colorEA6061, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${"Discarded".tr}20").paddingOnly(right: 12),
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.color638EFA, width: 2),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 10),
                    ],
                  ).paddingOnly(right: 14))
                ],
              ),
            ).paddingSymmetric(horizontal: 20, vertical: 22),
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
      ),
    );
  }
}

class TempData {
  final String title;
  final int value;

  TempData(this.title, this.value);
}
