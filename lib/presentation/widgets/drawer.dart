import 'package:flutter/material.dart';
import 'package:grievance_admin/utils/appcolors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor),
      ),
    );
  }
}
