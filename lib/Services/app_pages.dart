import 'package:get/get.dart';
import 'package:hmtl/Services/app_routes.dart';
import 'package:hmtl/UI/main/bindings/main_binding.dart';
import 'package:hmtl/UI/main/views/main_view.dart';
import 'package:hmtl/UI/profile/binding/profile_binding.dart';
import 'package:hmtl/UI/profile/views/profile_view.dart';
import 'package:hmtl/UI/splash/views/splash_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),
    GetPage(
      binding: MainBinding(),
      name: AppRoutes.main,
      page: () => MainView(),
    ),
    GetPage(
      binding: ProfileBinding(),
      name: AppRoutes.profile,
      page: () => ProfileView(),
    ),
  ];
}
