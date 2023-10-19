import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/controller/grievence_list_controller.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';
import 'package:grievance_admin/presentation/widgets/common_rowtext_field.dart';
import 'package:grievance_admin/presentation/widgets/common_table_button.dart';
import 'package:grievance_admin/presentation/widgets/common_textfield.dart';
import 'package:grievance_admin/utils/appcolors.dart';
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
          Stack(
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
                      border: Border.all(color: AppColors.whiteColor, width: 1),
                      color: AppColors.primaryRedColor,
                      shape: BoxShape.circle),
                ),
              ),
            ],
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
                Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Assets.images.icFilter.svg(),
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
                      DataCell(Text(
                        (i + 1).toString(),
                        style: TextStyle(
                            fontFamily: FontFamily.urbanistMedium,
                            fontSize: 10,
                            color: AppColors.textColor.withOpacity(0.5)),
                      )),
                      DataCell(Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonRowTextField(
                              title: "Gievance_Id".tr,
                              value: detail.idRequest ?? ""),
                          CommonRowTextField(
                              title: "Customer_name".tr,
                              value: detail.customerName ?? ""),
                          CommonRowTextField(
                              title: "Address".tr, value: detail.address ?? ""),
                          CommonRowTextField(
                              title: "Date_Created".tr,
                              value: DateFormat("dd MMM,yyyy")
                                  .format(detail.createdOn!)),
                          CommonRowTextField(
                              title: "Department".tr,
                              value: detail.department ?? ""),
                        ],
                      )),
                      DataCell(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(children: [
                            HTML.toTextSpan(context, detail.remarks ?? "",
                                defaultTextStyle: TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 10,
                                    color: AppColors.color999999)),
                            TextSpan(
                                text: "Remark".tr,
                                style: TextStyle(
                                    fontFamily: FontFamily.urbanistMedium,
                                    fontSize: 10,
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
                      )),
                      DataCell(SingleChildScrollView(
                        child: Column(
                          children: [
                            CommonTableButton(
                              text: "View_Grievances_Updates".tr,
                              onTap: () {},
                            ),
                            for (var i = 0;
                                i < detail.requestStatusArray!.length;
                                i++)
                              ExpansionTile(
                                  title: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: "Status".tr,
                                    style: const TextStyle(
                                        fontFamily: FontFamily.urbanistBold,
                                        fontSize: 8)),
                                TextSpan(
                                    text:
                                        detail.requestStatusArray![i].status ??
                                            "",
                                    style: const TextStyle(
                                        fontFamily: FontFamily.urbanistMedium,
                                        fontSize: 8))
                              ])))
                          ],
                        ),
                      )),
                      DataCell(detail.requestStatus == "1"
                          ? Text(
                              detail.status ?? "",
                              style: TextStyle(
                                  fontFamily: FontFamily.urbanistMedium,
                                  fontSize: 10,
                                  color: AppColors.textColor.withOpacity(0.5)),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  detail.status ?? "",
                                  style: TextStyle(
                                      fontFamily: FontFamily.urbanistMedium,
                                      fontSize: 10,
                                      color:
                                          AppColors.textColor.withOpacity(0.5)),
                                ).paddingOnly(bottom: 5),
                                const SizedBox(
                                  width: 110,
                                  height: 32,
                                ),
                              ],
                            )),
                      const DataCell(SizedBox(
                        width: 75,
                        height: 32,
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
                                fontSize: 10,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Grievance_Details".tr,
                              style: const TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 10,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Description".tr,
                              style: const TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 10,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Status_Updates".tr,
                              style: const TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 10,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Message_Updates".tr,
                              style: const TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 10,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Action".tr,
                              style: const TextStyle(
                                fontFamily: FontFamily.urbanistMedium,
                                fontSize: 10,
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
