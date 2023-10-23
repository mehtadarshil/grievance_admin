import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/routes/bindings/dashboard_binding.dart';
import 'package:grievance_admin/app/routes/bindings/grievance_email_history_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/grievence_list_bindings.dart';
import 'package:grievance_admin/app/routes/bindings/send_message_binding.dart';
import 'package:grievance_admin/app/routes/bindings/sign_in_bindings.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/presentation/pages/dashboard_page/dashboard_page.dart';
import 'package:grievance_admin/presentation/pages/grievence_list/grievence_list_page.dart';
import 'package:grievance_admin/presentation/pages/grivance_email_history/grievance_email_history_page.dart';
import 'package:grievance_admin/presentation/pages/send_message/send_message_page.dart';
import 'package:grievance_admin/presentation/pages/sign_in_page/sign_in_page.dart';

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
            bindings: GrievanceEmailHistoryBindings())
      ];
}

GetPage getPage(
        {required String name, required Widget page, Bindings? bindings}) =>
    GetPage(name: name, page: () => page, binding: bindings);
