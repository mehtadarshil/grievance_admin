import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/alert_page/controller/alert_page_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:intl/intl.dart';

class AlertPageScreen extends GetView<AlertPageController> {
  const AlertPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: "Alert".tr,
        actions: [
          ButtonBar(children: [
            GestureDetector(
              onTap: () {
                DialogUtil.sortOrderDialog();
              },
              child: Container(
                height: 32,
                width: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Assets.images.icFilter.svg(width: 12.31, height: 13.54),
              ),
            ),
          ])
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.colorFFF9F0,
                border: Border(
                    left: BorderSide(width: 5, color: AppColors.colorEDA32E))),
            child: Text(
              "You have 9 new status update(s).",
              style: TextStyle(
                  fontFamily: FontFamily.urbanistMedium,
                  fontSize: 16,
                  color: AppColors.colorEDA32E),
            ),
          ).paddingSymmetric(horizontal: 20, vertical: 30),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                color: AppColors.whiteColor,
                child: Row(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grievance G-0012 with status “Grievance Initiated” has been updated by on",
                            style: TextStyle(
                                color: AppColors.textColor.withOpacity(0.5),
                                fontSize: 16,
                                height: 1.5,
                                fontFamily: FontFamily.urbanistMedium),
                          ),
                          Text(
                            DateFormat("dd MMM,yyyy hh:mm:aa")
                                .format(DateTime.now()),
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontFamily: FontFamily.urbanistMedium),
                          )
                        ],
                      ).paddingSymmetric(vertical: 30, horizontal: 14),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: AppColors.borderColor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
