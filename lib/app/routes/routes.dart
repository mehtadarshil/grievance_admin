import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage<dynamic>> getRoutes() => [];
}

GetPage getPage(
        {required String name, required Widget page, Bindings? bindings}) =>
    GetPage(name: name, page: () => page, binding: bindings);
