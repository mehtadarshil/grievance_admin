import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:grievance_admin/app/core/api_client.dart';
import 'package:grievance_admin/app/core/api_const.dart';
import 'package:grievance_admin/app/models/send_message_model.dart';
import 'package:grievance_admin/app/models/sign_in_model.dart';
import 'package:grievance_admin/utils/dbkeys.dart';
import 'package:grievance_admin/utils/dialog_util.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class SendMessageController extends GetxController {
  final ApiClient _apiClient = Get.find();
  final String grievenceId = Get.arguments;
  final FocusNode focusNode = FocusNode();
  final TextEditingController subjectController = TextEditingController();
  final htmlKey = GlobalKey<QuillHtmlEditorState>();

  void sendMessage() async {
    var htmlText = await htmlKey.currentState?.getText();
    var formated = htmlText!.replaceAll("\\u", "").replaceAll("003C", "<");
    if (formated == "<p><br></p>") {
      DialogUtil.customDialog(title: "enter_proper_message".tr, error: true);
    } else if (subjectController.text.isEmpty) {
      DialogUtil.customDialog(title: "enter_proper_subject".tr, error: true);
    } else {
      var userData = UserData.fromJson(GetStorage().read(DbKeys.userData));
      var sendMessageJson = await _apiClient.post(
          path: ApiConst.wsRespondMailToUser,
          formData: FormData.fromMap({
            ApiConst.grievanceId: grievenceId,
            ApiConst.loggedinAdminId: userData.idAdmin ?? "",
            ApiConst.loggedinDepartmentId: userData.department ?? "",
            ApiConst.subject: subjectController.text,
            ApiConst.message: formated
          }));
      if (sendMessageJson != null) {
        SendMessageModel sendMessageModel =
            SendMessageModel.fromJson(sendMessageJson);
        if (sendMessageModel.status!) {
          DialogUtil.customDialog(title: "Message_sent_successfully".tr);
        } else {
          DialogUtil.customDialog(title: "Failed".tr, error: true);
        }
      }
    }
  }
}
