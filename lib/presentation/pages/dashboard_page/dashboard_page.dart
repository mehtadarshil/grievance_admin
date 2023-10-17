import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.headerColor),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
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
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.color638EFA, width: 2),
                              ),
                            ),
                            const Text("data")
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ).paddingSymmetric(horizontal: 20, vertical: 10)
        ],
      ),
    );
  }
}
