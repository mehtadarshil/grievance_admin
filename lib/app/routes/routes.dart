import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/routes/bindings/alert_binding.dart';
import 'package:grievance_admin/app/routes/bindings/assign_grievance_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/change_grievance_status_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/dashboard_binding.dart';
import 'package:grievance_admin/app/routes/bindings/edit_grievance_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/grievance_email_history_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/grievence_list_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/report_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/send_message_binding.dart';
import 'package:grievance_admin/app/routes/bindings/sign_in_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/status_history_binding.dart';
import 'package:grievance_admin/app/routes/bindings/transfer_grievance_bindings.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/presentation/pages/assign_grievance/assign_grievance_page.dart';
import 'package:grievance_admin/presentation/pages/edit_grievance_page/edit_grievance_page.dart';
import 'package:grievance_admin/presentation/pages/alert_page/alert_page_screen.dart';
import 'package:grievance_admin/presentation/pages/change_grievance_status/change_grievance_status_page.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/dashboard_page.dart';
import 'package:grievance_admin/presentation/pages/grievance_detail_page/grievance_detail_page.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/grievance_filter_page.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/grievence_list_page.dart';
import 'package:grievance_admin/presentation/pages/grivance_email_history/grievance_email_history_page.dart';
import 'package:grievance_admin/presentation/pages/report_page/report_page.dart';
import 'package:grievance_admin/presentation/pages/send_message/send_message_page.dart';
import 'package:grievance_admin/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:grievance_admin/presentation/pages/status_history_page/status_history_page.dart';
import 'package:grievance_admin/presentation/pages/transfer_grievance/transfer_grievance_page.dart';

class Routes {
  static List<GetPage<dynamic>> getRoutes() => [
        getPage(
            name: RouteList.signInPage,
            page: const SignInPage(),
            bindings: SignInBinding()),
        getPage(
            name: RouteList.dashboardPage,
            page: const DashboardPage(),
            bindings: DashboardBindings()),
        getPage(
            name: RouteList.grievenceList,
            page: const GrievenceListPage(),
            bindings: GrievenceListBindings()),
        getPage(
            name: RouteList.sendMessage,
            page: const SendMessagePage(),
            bindings: SendMessageBindings()),
        getPage(
            name: RouteList.grievanceEmailHistory,
            page: const GrievenceEmailHisoryPage(),
            bindings: GrievanceEmailHistoryBindings()),
        getPage(
            name: RouteList.transferGrievance,
            page: const TransferGrievancePage(),
            bindings: TransferGrievanceBindigns()),
        getPage(
            name: RouteList.changeGrievanceStatus,
            page: const ChangeGrievanceStatusPage(),
            bindings: ChangeGrievanceStatusBindings()),
        getPage(
            name: RouteList.alertPageScreen,
            page: const AlertPageScreen(),
            bindings: AlertBingings()),
        getPage(
          name: RouteList.grievanceFilterPage,
          page: const GrievanceFilterPage(),
        ),
        getPage(
            name: RouteList.statusHistoryPage,
            page: const StatusHistoryPage(),
            bindings: StatusHistoryBinding()),
        getPage(
            name: RouteList.editGrievancePage,
            page: const EditGrievancePage(),
            bindings: EditGrievanceBindings()),
        getPage(
            name: RouteList.reportPage,
            page: const ReportPage(),
            bindings: ReportBindings()),
        getPage(
            name: RouteList.grievanceDetails,
            page: const GrievanceDetailPage()),
        getPage(
            name: RouteList.assignGrievance,
            page: const AssignGrievancePage(),
            bindings: AssignGrievanceBindings())
      ];
}

GetPage getPage(
        {required String name, required Widget page, Bindings? bindings}) =>
    GetPage(name: name, page: () => page, binding: bindings);
