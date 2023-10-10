import 'package:flutter/material.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.textColor});

  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: FontFamily.urbanistBold,
              fontSize: 18,
              color: textColor),
        ));
  }
}
