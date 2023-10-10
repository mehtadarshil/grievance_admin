import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static prints(dynamic value) {
    if (kDebugMode) {
      log(value.toString());
    }
  }
}
