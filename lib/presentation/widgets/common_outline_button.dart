import 'package:flutter/material.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CommonOutlineButton extends StatelessWidget {
  const CommonOutlineButton(
      {super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.textColor, width: 2),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.textColor),
                borderRadius: BorderRadius.circular(200))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
              fontFamily: FontFamily.urbanistBold,
              fontSize: 18,
              color: AppColors.textColor),
        ));
  }
}
