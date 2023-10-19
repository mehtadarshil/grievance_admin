import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CommonTableButton extends StatelessWidget {
  const CommonTableButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.tableButtonBg,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: AppColors.blueTextColor,
              fontFamily: FontFamily.urbanistMedium,
              fontSize: 8),
        ).paddingSymmetric(horizontal: 7, vertical: 5),
      ),
    );
  }
}
