import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/app/routes/route_list.dart';
import 'package:grievance_admin/gen/assets.gen.dart';
import 'package:grievance_admin/gen/fonts.gen.dart';
import 'package:grievance_admin/presentation/widgets/common_button.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class DialogUtil {
  static void verifiedDialog() async {
    await showDialog(
      context: Get.context!,
      builder: (context) => const VerifiedDialog(),
    );
  }

  static void postGrievanceThankYouDialog() async {
    await showDialog(
      context: Get.context!,
      builder: (context) => const PostGrievanceThankYouDialog(),
    );
  }
}

class VerifiedDialog extends StatelessWidget {
  const VerifiedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 33),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Verified".tr,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistExtraBold, fontSize: 26),
              ),
              const SizedBox(
                height: 61,
              ),
              Assets.images.checkmark
                  .image(color: AppColors.greenColor, height: 80, width: 80),
              const SizedBox(
                height: 37,
              ),
              Text(
                "You_have_successfully_verified_the".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistRegular, fontSize: 16),
              ).paddingOnly(bottom: 8),
              Text(
                "grievance_admin".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistBold, fontSize: 16),
              ).paddingOnly(bottom: 15),
              CommonButton(
                text: "Send_Inquiry".tr,
                onTap: () {
                  Get.until(
                      (route) => route.settings.name == RouteList.homePage);
                  Get.toNamed(RouteList.postGrievancePage);
                },
                color: Colors.transparent,
                textColor: AppColors.primaryBlueColor,
              ),
              CommonButton(
                text: "Go_to_Dashboard".tr,
                onTap: () {
                  Get.offAllNamed(RouteList.dashboard);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PostGrievanceThankYouDialog extends StatelessWidget {
  const PostGrievanceThankYouDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 33),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Thank_You".tr,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistExtraBold, fontSize: 26),
              ),
              const SizedBox(
                height: 61,
              ),
              Assets.images.checkmark
                  .image(color: AppColors.greenColor, height: 80, width: 80),
              const SizedBox(
                height: 37,
              ),
              Text(
                "Submitting_your_grievances".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: FontFamily.urbanistRegular, fontSize: 16),
              ).paddingOnly(bottom: 60),
              CommonButton(
                text: "Go_to_Dashboard".tr,
                onTap: () {
                  Get.offAllNamed(RouteList.dashboard);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
