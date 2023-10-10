import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/di/app_base_component.dart';
import 'package:grievance_admin/utils/logger.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> get({
    required String path,
    Map<String, String>? headers,
  }) async {
    AppComponentBase.instance.showProgressDialog();
    try {
      String username = 'admin';
      String password = '1234';
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      Map<String, String> rawHeader = {
        ApiConst.authorization: basicAuth,
        ApiConst.apiKey: ApiConst.apiKeyValue
      };

      if (headers != null) {
        rawHeader.addAll(headers);
      }

      var response = await _dio.get("${ApiConst.baseUrl}$path",
          options: Options(headers: rawHeader));
      if (response.statusCode == 200 || response.statusCode == 400) {
        AppComponentBase.instance.hideProgressDialog();
        return response.data;
      } else {
        AppComponentBase.instance.hideProgressDialog();
        return null;
      }
    } catch (e) {
      AppComponentBase.instance.hideProgressDialog();
      Logger.prints(e);
      return null;
    }
  }

  Future<dynamic> post(
      {required String path,
      Map<String, String>? headers,
      FormData? formData}) async {
    AppComponentBase.instance.showProgressDialog();
    try {
      String username = 'admin';
      String password = '1234';
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      Map<String, String> rawHeader = {
        ApiConst.authorization: basicAuth,
        ApiConst.apiKey: ApiConst.apiKeyValue,
      };

      if (headers != null) {
        rawHeader.addAll(headers);
      }
      Logger.prints("${ApiConst.baseUrl}$path");
      var response = await _dio.post("${ApiConst.baseUrl}$path",
          data: formData, options: Options(headers: rawHeader));
      Logger.prints(response.data);
      if (response.statusCode == 200 || response.statusCode == 400) {
        AppComponentBase.instance.hideProgressDialog();
        return response.data;
      } else {
        AppComponentBase.instance.hideProgressDialog();
        return null;
      }
    } catch (e) {
      AppComponentBase.instance.hideProgressDialog();
      Logger.prints(e);
      return null;
    }
  }

  Future<dynamic> put(
      {required String path,
      Map<String, String>? headers,
      Map<String, String>? formData}) async {
    AppComponentBase.instance.showProgressDialog();
    try {
      String username = 'admin';
      String password = '1234';
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      Map<String, String> rawHeader = {
        ApiConst.authorization: basicAuth,
        ApiConst.apiKey: ApiConst.apiKeyValue
      };

      if (headers != null) {
        rawHeader.addAll(headers);
      }
      Logger.prints("${ApiConst.baseUrl}$path");
      var response = await _dio.put("${ApiConst.baseUrl}$path",
          data: formData,
          options: Options(
            headers: rawHeader,
          ));
      Logger.prints(response.data);
      if (response.statusCode == 200 || response.statusCode == 400) {
        AppComponentBase.instance.hideProgressDialog();
        return response.data;
      } else {
        AppComponentBase.instance.hideProgressDialog();
        return null;
      }
    } catch (e) {
      AppComponentBase.instance.hideProgressDialog();
      Logger.prints(e);
      return null;
    }
  }
}
