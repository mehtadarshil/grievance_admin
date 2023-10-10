import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/appcolors.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
        color: AppColors.primaryBlueColor, size: 40);
  }
}
