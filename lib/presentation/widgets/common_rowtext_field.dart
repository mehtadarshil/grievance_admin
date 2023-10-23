import 'package:flutter/material.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CommonRowTextField extends StatelessWidget {
  const CommonRowTextField(
      {super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: title,
            style: const TextStyle(
              fontFamily: FontFamily.urbanistBold,
              fontSize: 14,
            )),
        TextSpan(
            text: value,
            style: TextStyle(
              fontFamily: FontFamily.urbanistMedium,
              color: AppColors.color999999,
              fontSize: 14,
            ))
      ]),
    );
  }
}
