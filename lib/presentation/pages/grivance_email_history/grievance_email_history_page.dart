import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grivance_email_history/controller/grievance_email_history_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:intl/intl.dart';
import 'package:simple_html_css/simple_html_css.dart';

class GrievenceEmailHisoryPage
    extends GetView<GrievanceEmailHistoryController> {
  const GrievenceEmailHisoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CommonAppbar(title: "Email_History".tr),
      body: Obx(
        () => controller.emailHistory.value == null
            ? const SizedBox.shrink()
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemCount: controller.emailHistory.value!.data!.length,
                itemBuilder: (context, index) {
                  var detail = controller.emailHistory.value!.data![index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.bgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: detail.sendBy == "Admin"
                                        ? "From_Admin_to_You".tr
                                        : "From_You_to_Admin".tr,
                                    style: const TextStyle(
                                        fontFamily: FontFamily.urbanistSemiBold,
                                        fontSize: 15)),
                                const TextSpan(
                                    text: " || ",
                                    style: TextStyle(
                                        fontFamily: FontFamily.urbanistSemiBold,
                                        fontSize: 15)),
                                TextSpan(
                                    text: DateFormat("dd MMM,yyyy hh:mm:aa")
                                        .format(detail.createdOn!),
                                    style: const TextStyle(
                                        fontFamily: FontFamily.urbanistSemiBold,
                                        fontSize: 15))
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(vertical: 5),
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "${"Subject".tr} : ",
                              style: const TextStyle(
                                  fontFamily: FontFamily.urbanistSemiBold,
                                  fontSize: 15)),
                          TextSpan(
                              text: detail.subject ?? "",
                              style: const TextStyle(
                                  fontFamily: FontFamily.urbanistRegular,
                                  fontSize: 15))
                        ])).paddingOnly(bottom: 5, left: 10, right: 10),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "${"Message_field".tr} : ",
                              style: const TextStyle(
                                  fontFamily: FontFamily.urbanistSemiBold,
                                  fontSize: 15)),
                          HTML.toTextSpan(
                              context,
                              (detail.emailStatusRemarks ?? "")
                                  .replaceAll("\\", ""),
                              defaultTextStyle: const TextStyle(
                                  fontFamily: FontFamily.urbanistRegular,
                                  fontSize: 15))
                        ])).paddingOnly(bottom: 5, left: 10, right: 10),
                      ],
                    ),
                  ).paddingOnly(bottom: 5);
                },
              ),
      ),
    );
  }
}
