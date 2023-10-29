import 'package:flutter/material.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class FilterCardWidget extends StatelessWidget {
  const FilterCardWidget(
      {super.key,
      required this.title,
      required this.count,
      required this.selected});

  final String title;
  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
      decoration: BoxDecoration(
          color: selected ? AppColors.tableButtonBg : AppColors.headerColor,
          borderRadius: BorderRadius.circular(3)),
      child: Text(
        "$title ($count)",
        style: TextStyle(
            color: selected ? AppColors.blueTextColor : null,
            fontSize: 12,
            fontFamily: FontFamily.urbanistMedium),
      ),
    );
  }
}
