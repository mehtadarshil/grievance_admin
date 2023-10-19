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
      this.textInputType,
      this.obscureText = false,
      this.prefixIcon,
      this.borderColor});
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final TextInputType? textInputType;
  final Widget? icon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final int? maxLines;
  final Function(String value)? onChange;
  final bool obscureText;

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
          obscureText: obscureText,
          readOnly: onTap != null,
          maxLines: obscureText ? 1 : maxLines,
          decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              suffixIcon: icon,
              prefixIcon: prefixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
              hintStyle: TextStyle(
                  fontFamily: FontFamily.urbanistMedium,
                  fontSize: 16,
                  color: borderColor != null
                      ? AppColors.textColor.withOpacity(0.5)
                      : AppColors.textColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: borderColor != null
                      ? BorderSide(color: borderColor!, width: 1)
                      : BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: borderColor != null
                      ? BorderSide(color: borderColor!, width: 1)
                      : BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: borderColor != null
                      ? BorderSide(color: borderColor!, width: 1)
                      : BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: borderColor != null
                      ? BorderSide(color: borderColor!, width: 1)
                      : BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: borderColor != null
                      ? BorderSide(color: borderColor!, width: 1)
                      : BorderSide.none),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: borderColor != null
                      ? BorderSide(color: borderColor!, width: 1)
                      : BorderSide.none),
              fillColor: AppColors.whiteColor),
        )
      ],
    );
  }
}
