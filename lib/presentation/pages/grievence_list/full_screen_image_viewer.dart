import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grievance_admin/presentation/widgets/common_appbar.dart';

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: "Image".tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
