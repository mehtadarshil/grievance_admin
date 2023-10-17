import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CommonAppbar extends AppBar {
  CommonAppbar(
      {super.key,
      required String title,
      String? subTitle,
      bool splitTitle = false,
      List<Widget>? actions,
      VoidCallback? onLeadingTap})
      : super(
          backgroundColor: AppColors.whiteColor,
          elevation: 2,
          centerTitle: true,
          foregroundColor: AppColors.blackColor,
          toolbarHeight: subTitle != null ? 112 : null,
          title: subTitle != null
              ? Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.urbanistBold,
                          fontSize: 22),
                    ).paddingOnly(bottom: 16),
                    Text(
                      subTitle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.urbanistRegular,
                          fontSize: 16),
                    )
                  ],
                )
              : splitTitle
                  ? Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "${title.split(" ").elementAt(0)} ",
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontFamily: FontFamily.urbanistBold,
                              fontSize: 22)),
                      TextSpan(
                          text: title.split(" ").elementAt(1),
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontFamily: FontFamily.urbanistLight,
                              fontSize: 22))
                    ]))
                  : Text(
                      title,
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.urbanistBold,
                          fontSize: 22),
                    ),
          actions: subTitle != null
              ? [
                  const SizedBox(
                    width: 40,
                  )
                ]
              : actions,
          leading: onLeadingTap != null
              ? GestureDetector(
                  onTap: onLeadingTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Assets.images.shape2.svg(height: 24, width: 24)],
                  ),
                )
              : null,
        );
}
