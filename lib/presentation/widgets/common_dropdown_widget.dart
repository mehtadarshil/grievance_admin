import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/models/dropdown_data_model.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CommonDropdown extends StatelessWidget {
  const CommonDropdown(
      {super.key,
      required this.data,
      required this.value,
      this.onChange,
      this.title});

  final List<DropDownDataModel> data;
  final String value;
  final Function(String? value)? onChange;
  final String? title;

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
        Container(
          height: 60,
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 21),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.borderColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            value: value,
            isExpanded: true,
            isDense: true,
            underline: const SizedBox.shrink(),
            items: data
                .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: Text(e.text),
                    ))
                .toList(),
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
