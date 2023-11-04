import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/models/grievence_list_model.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/utils/appcolors.dart';
import 'package:intl/intl.dart';

class GrievanceDetailPage extends StatelessWidget {
  const GrievanceDetailPage({super.key});

  static GDatum grievanceDetails = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: "Grievance_Details".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "${"Request_Id".tr} : ",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistSemiBold,
                            fontSize: 15)),
                    TextSpan(
                        text: grievanceDetails.uniqueRequestId ?? "",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistRegular,
                            fontSize: 15))
                  ])).paddingOnly(bottom: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "${"Customer_Name".tr} : ",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistSemiBold,
                            fontSize: 15)),
                    TextSpan(
                        text: grievanceDetails.customerName ?? "",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistRegular,
                            fontSize: 15))
                  ])).paddingOnly(bottom: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "${"Description".tr} : ",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistSemiBold,
                            fontSize: 15)),
                    TextSpan(
                        text: grievanceDetails.requestDescription ?? "",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistRegular,
                            fontSize: 15))
                  ])).paddingOnly(bottom: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "${"Date_Created".tr} : ",
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistSemiBold,
                            fontSize: 15)),
                    TextSpan(
                        text: DateFormat("dd MMM,yyyy hh:mm:aa")
                            .format(grievanceDetails.createdOn!),
                        style: const TextStyle(
                            fontFamily: FontFamily.urbanistRegular,
                            fontSize: 15))
                  ])).paddingOnly(bottom: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
