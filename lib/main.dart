import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hmtl/Services/app_pages.dart';
import 'package:hmtl/Services/app_routes.dart';
import 'package:hmtl/Utils/utils.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:sizer/sizer.dart';

void main() async {
  ///
  WidgetsFlutterBinding.ensureInitialized();
  // REQUIRED — initialize the MediaStore plugin
  await MediaStore.ensureInitialized();

  // REQUIRED — your plugin needs an app folder
  MediaStore.appFolder = "HMTL"; // you can name anything, but must not be empty
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Sizer(
        builder: (buildContext, orientation, screenType) {
          return GetMaterialApp(
            title: 'HMT Calc',
            navigatorKey: Utils.navigatorKey,
            builder: (context, child) {
              return ScrollConfiguration(
                  behavior: CustomScrollBehavior(), child: child!);
            },
            localizationsDelegates: [
              // GlobalMaterialLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorSchemeSeed: Color(0xff17509d),
                scaffoldBackgroundColor: Color(0xffEFEFED)),
            initialRoute: AppRoutes.splash,
            getPages: AppPages.pages,
          );
        },
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics();
  }
}
