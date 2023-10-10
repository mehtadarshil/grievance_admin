import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key,
      required this.onTap,
      required this.title,
      this.secondTitle,
      required this.image,
      required this.color});
  final VoidCallback onTap;
  final String title;
  final String? secondTitle;
  final AssetGenImage image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteColor),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: color),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image.image(height: 26, width: 26),
                ],
              ),
            ).paddingAll(18),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontFamily: FontFamily.urbanistBold, fontSize: 18),
                  ),
                  if (secondTitle != null)
                    const SizedBox(
                      width: 14,
                    ),
                  if (secondTitle != null)
                    Text(
                      secondTitle!,
                      style: const TextStyle(
                          fontFamily: FontFamily.urbanistMedium, fontSize: 12),
                    )
                ],
              ),
            ),
            Transform.rotate(
                angle: pi,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                )).paddingOnly(right: 14)
          ],
        ),
      ),
    );
  }
}
