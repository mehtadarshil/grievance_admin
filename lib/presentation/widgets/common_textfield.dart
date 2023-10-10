import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.title,
      required this.hintText,
      required this.controller,
      this.onTap,
      this.icon,
      this.maxLines,
      this.onChange,
      this.textInputType});
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final TextInputType? textInputType;
  final Widget? icon;
  final int? maxLines;
  final Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Opacity(
            opacity: 0.6,
            child: Text(
              title ?? "",
              style: const TextStyle(
                  fontFamily: FontFamily.urbanistMedium, fontSize: 16),
            ),
          ).paddingOnly(bottom: 11),
        TextField(
          controller: controller,
          onTap: onTap,
          keyboardType: textInputType,
          onChanged: onChange,
          readOnly: onTap != null,
          maxLines: maxLines,
          decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              suffixIcon: icon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
              hintStyle: TextStyle(
                  fontFamily: FontFamily.urbanistMedium,
                  fontSize: 16,
                  color: AppColors.textColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              fillColor: AppColors.whiteColor),
        )
      ],
    );
  }
}
