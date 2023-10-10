import 'package:flutter/material.dart';
import 'package:grievance_admin/app/di/app_base_component.dart';

WillPopScope backHanlder({Future<bool>? onBack, required Widget child}) =>
    WillPopScope(
        onWillPop: () async {
          if (AppComponentBase.instance.loading) {
            return false;
          } else if (onBack != null) {
            return await onBack;
          } else {
            return true;
          }
        },
        child: child);
