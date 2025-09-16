import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/Services/app_routes.dart';
import 'package:hmtl/Utils/app_colors.dart';
import 'package:hmtl/Utils/app_strings.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    goToHome();

    return Scaffold(
      backgroundColor: AppColor.primaryRedColor,
      body: Center(
        child: Image.asset(AppImage.splashLogo,width: 80.w),
      ),
    );
  }

  void goToHome() {
    Future.delayed(Duration(milliseconds: 2000),() {
      Get.offNamed(AppRoutes.main);
    });
  }
}
