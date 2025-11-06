import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/UI/about/views/about_view.dart';
import 'package:hmtl/UI/about/views/bout_view.dart';
import 'package:hmtl/UI/chemical/views/chemical_view.dart';
import 'package:hmtl/UI/gauge/views/gauge_view.dart';
import 'package:hmtl/UI/main/controllers/main_controller.dart';
import 'package:hmtl/UI/manual/views/manual_view.dart';
import 'package:hmtl/UI/nps/views/nps_view.dart';
import 'package:hmtl/Utils/app_colors.dart';

class MainView extends GetView<MainController> {
  MainView({super.key});

  final List<Widget> _pages = [
    ManualView(),
    NpsView(),
    AboutView(),


    GaugeView(),
    ChemicalView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: _pages[controller.currentPage.value],
          bottomNavigationBar: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColor.primaryRedColor,
              // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / controller.tabs.length;
                final itemHeight = constraints.maxHeight;

                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: itemWidth * controller.currentPage.value,
                      top: 10,
                      bottom: 10,
                      width: itemWidth,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(controller.tabs.length, (index) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.currentPage.value = index;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                controller.tabs[index],
                                style: TextStyle(
                                  color: controller.currentPage.value == index ? AppColor.primaryRedColor : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
