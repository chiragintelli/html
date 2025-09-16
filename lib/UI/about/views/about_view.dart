import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/UI/main/controllers/main_controller.dart';
import 'package:hmtl/Utils/app_colors.dart';
import 'package:hmtl/Utils/app_strings.dart';
import 'package:sizer/sizer.dart';

class AboutView extends GetView<MainController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColor.primaryBlueColor),
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 20,
                ),
                Text(
                  'About App',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: Column(
                      children: [
                        Container(child: Column(children: [
                          Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Image.asset(AppImage.about1)),
                          SizedBox(height: 10),
                          Text('Cold finished Tubes / Pipes are produced out of quality seamless hollows which are manufactured in house or procured from reputed mills. Seamless hollows are either cold pilgered over pilger mills or cold drawn over draw benches using precision tooling (dies & plugs) to achieve perfect dimensions and smooth surfaces.',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                        ])),
                        SizedBox(height: 20),
                        Container(child: Column(children: [
                          Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Image.asset(AppImage.about2)),
                          SizedBox(height: 10),
                          Text('HMT has a dedicated plant of 13,500 sq. mtr. of covered area for manufacturing cold drawn of Carbon & Alloy Steel Tubes / pipes.',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                        ])),
                        SizedBox(height: 20),
                        Container(child: Column(children: [
                          Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Image.asset(AppImage.about3)),
                          SizedBox(height: 10),
                          Text('HMT manufactures specialized tubes for various mechanical applications in Boilers and Boiler components, Economizers, Heat Exchangers and pipes used for cryogenic applications. These items can be customized to the requirement of individual customers in terms of heat treatment end end finishes.',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                        ])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: () {
                              controller.launchWebUrl();
                            },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)
                                  )
                                ),
                                child: Text('Visit hmtl.in')),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
