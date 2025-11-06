import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/Services/app_routes.dart';
import 'package:hmtl/UI/manual/controllers/manual_controller.dart';
import 'package:hmtl/Utils/app_colors.dart';
import 'package:hmtl/Utils/app_strings.dart';
import 'package:hmtl/Utils/utils.dart';
import 'package:sizer/sizer.dart';

class ManualView extends StatefulWidget {
  const ManualView({super.key});

  @override
  State<ManualView> createState() => _ManualViewState();
}

class _ManualViewState extends State<ManualView> {
  ManualController controller = Get.put(ManualController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.selectedUnitIndex.value;
      return Column(children: [
        Container(
          decoration: BoxDecoration(color: AppColor.primaryBlueColor),
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Opacity(
                      opacity: 0,
                      child: Icon(Icons.account_box_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Text(
                    'Switch units',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.find<MainController>().currentPage.value = 2;
                      Get.toNamed(AppRoutes.profile);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.account_circle_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                // color: Colors.blue[800],
                // padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Container(
                    height: 40,
                    width: 160,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlueDarkColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double itemWidth = constraints.maxWidth / controller.units.length;

                        return Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              left: controller.selectedUnitIndex.value * itemWidth,
                              width: itemWidth,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(controller.units.length, (index) {
                                bool isSelected = index == controller.selectedUnitIndex.value;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectedUnitIndex.value = index;
                                      if (controller.textEditingControllerOd.text.isEmpty) {
                                        controller.focusNodeOd.requestFocus();
                                      }
                                      controller.resetCalc();
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        controller.units[index],
                                        style: TextStyle(
                                          color: isSelected ? Colors.blue[800] : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
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
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 40),
              //   child: Text(
              //     'Enter pipe dimensions to calculate weights and costs',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w600,
              //       fontSize: 16,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // SizedBox(height: 20),
              Container(
                // height: 15.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 7,
                      right: 0,
                      left: 0,
                      child: Image.asset(AppImage.hmtlLogo, height: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ClipPath(
                        clipper: NotchedClipper(),
                        child: Container(
                          padding: EdgeInsets.only(top: 10, left: 12, right: 12,bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor.primaryBlueColor,
                                AppColor.primaryBlueDarkColor,
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pipe Weights',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                      child: TextField(
                                        controller: controller.textEditingControllerOd,
                                        focusNode: controller.focusNodeOd,
                                        readOnly: true,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          labelText: 'OD',
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          floatingLabelStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.isComputed(false);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                      child: TextField(
                                        controller: controller.textEditingControllerThk,
                                        focusNode: controller.focusNodeThk,
                                        readOnly: true,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          labelText: 'THK',
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          floatingLabelStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.isComputed(false);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                      child: TextField(
                                        controller: controller.textEditingControllerId,
                                        focusNode: controller.focusNodeId,
                                        readOnly: true,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          labelText: 'ID',
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          floatingLabelStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.isComputed(false);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.selectedUnitIndex.value == 1) ...[
                                if (controller.textEditingControllerOd.text.isNotEmpty ||
                                    controller.textEditingControllerId.text.isNotEmpty ||
                                    controller.textEditingControllerThk.text.isNotEmpty)
                                  SizedBox(height: 10),
                                Container(
                                  // padding: EdgeInsets.symmetric(horizontal: 10),
                                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
                                  child: Column(
                                    children: [
                                      // Text('In mm',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),

                                      Row(
                                        children: [
                                          // SizedBox(width: 10),
                                          Expanded(
                                            child: controller.textEditingControllerOd.text.isNotEmpty
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    // padding: EdgeInsets.symmetric(horizontal: 10),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                                    child: Text(
                                                        (Utils.parseToDouble(controller.textEditingControllerOd.text, toMM: true)).toStringAsFixed(2),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.clip,
                                                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)))
                                                : SizedBox(),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: controller.textEditingControllerThk.text.isNotEmpty
                                                ? Container(
                                                alignment: Alignment.center,
                                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                                child: Text(
                                                    (Utils.parseToDouble(controller.textEditingControllerThk.text, toMM: true)).toStringAsFixed(2),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)))
                                                : SizedBox(),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: controller.textEditingControllerId.text.isNotEmpty
                                                ? Container(
                                                alignment: Alignment.center,
                                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                                child: Text(
                                                    (Utils.parseToDouble(controller.textEditingControllerId.text, toMM: true)).toStringAsFixed(2),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)))
                                                : SizedBox(),
                                          ),
                                          // SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // if(controller.selectedUnitIndex.value==1)...[
              //   SizedBox(height: 10),
              //   Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10),
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
              //     child: Column(
              //       children: [
              //         Text('In mm',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              //         Row(
              //           children: [
              //             Expanded(
              //               child:
              //               controller.textEditingControllerOd.text.isNotEmpty?
              //               Container(
              //                   padding: EdgeInsets.symmetric(horizontal: 10),
              //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              //                   child: Text('Od: ${Utils.parseToDouble(controller.textEditingControllerOd.text)*25.4}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
              //               ):SizedBox(),
              //             ),
              //             SizedBox(width: 10),
              //             Expanded(
              //               child:
              //               controller.textEditingControllerId.text.isNotEmpty?
              //               Container(
              //                   padding: EdgeInsets.symmetric(horizontal: 10),
              //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              //                   child: Text('Id: ${Utils.parseToDouble(controller.textEditingControllerId.text)*25.4}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
              //               ):SizedBox(),
              //             ),
              //             SizedBox(width: 10),
              //             Expanded(
              //               child:
              //               controller.textEditingControllerThk.text.isNotEmpty?
              //               Container(
              //                   padding: EdgeInsets.symmetric(horizontal: 10),
              //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              //                   child: Text('Thk: ${Utils.parseToDouble(controller.textEditingControllerThk.text)*25.4}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
              //               ):SizedBox(),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ],
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryRedColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      controller.calculateValue();
                    },
                    child: Text(
                      'Let\'s Compute!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffEFEFED),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.primaryRedColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      controller.resetCalc();
                      setState(() {});
                    },
                    child: Text(
                      '   Reset   ',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (!controller.isComputed.value) ...[
                controller.selectedUnitIndex.value == 1
                    ? Keyboard((value) {
                        setState(() {
                          try {
                            print(controller.textEditingControllerId.text.substring(controller.textEditingControllerId.text.length - 3));
                          } catch (e) {
                            print('object');
                          }
                          // print('value - $value');
                          // print('parse - ${Utils.parseToDouble(value,toMM: true)}');

                          controller.enterValue(value);
                        });
                      })
                    : InchKeyboard((value) {
                        setState(() {
                          try {
                            print(controller.textEditingControllerId.text.substring(controller.textEditingControllerId.text.length - 3));
                          } catch (e) {
                            print('object');
                          }
                          // Utils.parseToDouble(value);
                          controller.enterValue(value);
                        });
                      }),
              ],

              if (controller.isComputed.value) ...[
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
                      verticalInside: BorderSide(width: 1, color: Colors.grey.shade300),
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          TableCell(
                            child: SizedBox(height: 40, child: Center(child: Text(' ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(child: Text('kg/m', maxLines: 1, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(child: Text('kg/ft', maxLines: 1, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(child: Text('lbs/m', maxLines: 1, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(child: Text('lbs/feet', maxLines: 1, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                          ),
                        ],
                      ),
                      TableRow(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            TableCell(
                              child:
                                  Container(
                                      color: Colors.red,
                                      height: 40, child: Center(child: Text('CS', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(controller.kgm.toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text((controller.kgm / 3.2808).toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text((controller.kgm * 2.2046226).toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(((controller.kgm * 2.2046226) / 3.2808).toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            TableCell(
                              child: Container(
                                      color: Colors.red,
                                      height: 40, child: Center(child: Text('SS', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16))),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(controller.ckgm.toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text((controller.ckgm / 3.2808).toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text((controller.ckgm * 2.2046226).toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                      ),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(((controller.ckgm * 2.2046226) / 3.2808).toStringAsFixed(2),
                                          maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                  ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        // controller: controller.textEditingControllerOd,
                        // focusNode: controller.focusNodeOd,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Rate',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          floatingLabelStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        onChanged: (value) {
                          controller.getRates(r: value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                        showDialog(
                          context: context,
                          builder: (context) {
                            return MediaQuery.removeViewInsets(
                              context: context,
                              removeBottom: true,
                              child: Dialog(
                                backgroundColor: Colors.white,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: SizedBox(
                                  // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  child: Obx(() {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.(8),
                                            color: AppColor.primaryBlueColor,
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 15),
                                          child: Column(children: [
                                            Text(
                                              'Exchange Currency',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.whiteColor,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: SizedBox(
                                                height: 40,
                                                child: TextField(
                                                  onChanged: (value) {
                                                    controller.filterCurrencyList(value);
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                    hintText: 'Search Currency',
                                                    hintStyle: TextStyle(color: Colors.grey),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: Colors.white)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: Colors.white)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Column(
                                              children: [
                                                if (!controller.isFiltered.value) ...[
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                          child: Divider(
                                                            color: Colors.grey.shade400,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Popular Currencies',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                          child: Divider(
                                                            color: Colors.grey.shade400,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: List.generate(
                                                      controller.suggestedList.length,
                                                          (index) {
                                                        var country = controller.suggestedList[index];
                                                        if (country.isNotEmpty) {
                                                          if (controller.selectedCurrency.isNotEmpty) {
                                                            if (controller.selectedCurrency[0] == country[0]) {
                                                              return ListTile(
                                                                minTileHeight: 40,
                                                                onTap: () {

                                                                  controller.selectedCurrency.value = controller.suggestedList[index];
                                                                  controller.fetchCurrencyDetails(controller.selectedCurrency[0].toString());
                                                                  Get.back();
                                                                },
                                                                // onTap: () {
                                                                //   controller.selectedCurrency.value = controller.suggestedList[index];
                                                                //   print('object ${controller.selectedCurrency}');
                                                                //
                                                                //   Get.back();
                                                                // },
                                                                title: Text(country[0] + ' - ' + country[1]),
                                                                trailing:
                                                                Icon(Icons.check_circle, color: AppColor.primaryBlueColor, size: 25),
                                                              );
                                                            }
                                                          }

                                                          return ListTile(

                                                            minTileHeight: 40,
                                                            onTap: () {

                                                              controller.selectedCurrency.value = controller.suggestedList[index];
                                                              controller.fetchCurrencyDetails(controller.selectedCurrency[0].toString());
                                                              Get.back();
                                                            },
                                                            title: Text(country[0] + ' - ' + country[1]),
                                                          );
                                                        } else {
                                                          return SizedBox();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                          child: Divider(
                                                            color: Colors.grey.shade300,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'All',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                          child: Divider(
                                                            color: Colors.grey.shade300,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                Column(
                                                  children: List.generate(
                                                    controller.filteredCountryList.length,
                                                        (index) {
                                                      var country = controller.filteredCountryList[index];
                                                      if (country.isNotEmpty) {
                                                        if (controller.selectedCurrency.isNotEmpty) {
                                                          if (controller.selectedCurrency[0] == country[0]) {
                                                            return ListTile(
                                                              minTileHeight: 40,
                                                              onTap: () {

                                                                controller.selectedCurrency.value = controller.filteredCountryList[index];
                                                                controller.fetchCurrencyDetails(controller.selectedCurrency[0].toString());
                                                                Get.back();
                                                              },
                                                              title: Text(country[0] + ' - ' + country[1]),
                                                              trailing:
                                                              Icon(Icons.check_circle, color: AppColor.primaryBlueColor, size: 25),
                                                            );
                                                          }
                                                        }

                                                        return ListTile(
                                                          minTileHeight: 40,
                                                          onTap: () {

                                                            controller.selectedCurrency.value = controller.filteredCountryList[index];
                                                            controller.fetchCurrencyDetails(controller.selectedCurrency[0].toString());
                                                            Get.back();
                                                          },
                                                          title: Text(country[0] + ' - ' + country[1]),
                                                        );
                                                      } else {
                                                        return SizedBox();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            );
                          },
                        ).then((value) {
                          controller.isFiltered(false);
                          controller.resetList();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                        child: controller.loadingCurrency.value?
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(child: CircularProgressIndicator()),
                            ):
                        TextField(
                          controller: controller.textEditingControllerExgRate,
                          // focusNode: controller.focusNodeOd,
                          // readOnly: true,
                          // showCursor: false,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            labelText: 'Exchange Rate',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          // onChanged: (value) {
                          //   _getRates(exgRate: value);
                          // },
                        ),
                      ),
                    ),
                  )
                ]),
                SizedBox(height: 20),
                Row(children: [
                  // Expanded(
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  //     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                  //     child: Text(
                  //       controller.rateKg.value==0.0? 'Rate (KG)':controller.rateKg.value.toString(),
                  //       style: TextStyle(
                  //         color: Colors.grey.shade700,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        enabled: false,
                        controller: controller.textEditingControllerRateKg,
                        // focusNode: controller.focusNodeOd,
                        // readOnly: true,
                        // showCursor: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Rate (KG)',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          floatingLabelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        onSubmitted: (value) {
                          controller.getRates(ex: value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        enabled: false,
                        controller: controller.textEditingControllerRateLbs,
                        // focusNode: controller.focusNodeOd,
                        // readOnly: true,
                        // showCursor: true,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Rate (LBS)',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          floatingLabelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        onSubmitted: (value) {
                          controller.getRates(ex: value);
                        },
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                Obx(() {
                  controller.changing.value;
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Table(
                        border: TableBorder(
                          horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
                          verticalInside: BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            children: [
                              TableCell(
                                child: SizedBox(
                                    height: 40, child: Center(child: Text(controller.selectedCurrency.isNotEmpty ? "In ${controller.selectedCurrency[0].toString()}" : ' ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                              ),
                              TableCell(
                                child: Container(
                                    color: AppColor.primaryBlueColor,
                                    height: 40,
                                    child: Center(child: Text('Rate/Meter', maxLines: 1, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                              ),
                              TableCell(
                                child: Container(
                                    color: AppColor.primaryBlueColor,
                                    height: 40,
                                    child: Center(child: Text('Rate/feet', maxLines: 1, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                              ),
                            ],
                          ),
                          TableRow(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              children: [
                                TableCell(
                                  child:
                                      Container(color: Colors.red,height: 40, child: Center(child: Text('CS', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                                ),
                                TableCell(
                                  child: SizedBox(
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                              (controller.kgm.value * Utils.parseToDouble(controller.textEditingControllerRateKg.text)).toStringAsFixed(2),
                                              maxLines: 1,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                                ),
                                TableCell(
                                  child: SizedBox(
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                              ((controller.kgm / 3.2808) * Utils.parseToDouble(controller.textEditingControllerRateKg.text))
                                                  .toStringAsFixed(2),
                                              maxLines: 1,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                                ),
                              ]),
                          TableRow(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              children: [
                                TableCell(
                                  child:
                                      Container(
                                          color: Colors.red,
                                          height: 40, child: Center(child: Text('SS', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 16)))),
                                ),
                                TableCell(
                                  child: SizedBox(
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                              (controller.ckgm * Utils.parseToDouble(controller.textEditingControllerRateLbs.text) * 2.2046226)
                                                  .toStringAsFixed(2),
                                              maxLines: 1,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                                ),
                                TableCell(
                                  child: SizedBox(
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                              ((controller.ckgm / 3.2808) * Utils.parseToDouble(controller.textEditingControllerRateLbs.text) * 2.2046226)
                                                  .toStringAsFixed(2),
                                              maxLines: 1,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)))),
                                ),
                              ]),
                        ],
                      ),
                    );
                  }),
              ]
            ],
          ),
        ),
      ]);
    });
  }

}

class NotchedClipper extends CustomClipper<Path> {
  final notch = CircularNotchedRectangle();

  @override
  Path getClip(Size size) {
    final host = Rect.fromLTWH(0, 0, size.width, size.height);
    final guest = Rect.fromCircle(
      center: Offset(size.width / 2, 0), // notch at center top
      radius: 20, // match the size of FAB (default radius = 28 for 56x56 FAB)
    );
    return notch.getOuterPath(host, guest);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Keyboard extends StatelessWidget {
  final void Function(String) cb;

  const Keyboard(this.cb, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 38.h,
      child: Column(
        children: <Widget>[
          ButtonRow([
            Button(text: '1/6', cb: cb),
            Button(text: '1/8', cb: cb),
            Button(text: '3/16', cb: cb),
            Button(text: '1/4', cb: cb),
            Button(text: '1/16', cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            Button(text: '3/8', cb: cb),
            Button(text: '7/16', cb: cb),
            Button(text: '1/2', cb: cb),
            Button(text: '9/16', cb: cb),
            Button(text: '5/8', cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            Button(text: '11/16', cb: cb),
            Button(text: '3/4', cb: cb),
            Button(text: '13/16', cb: cb),
            Button(text: '7/8', cb: cb),
            Button(text: '15/16', cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            Button(text: '9', cb: cb),
            Button(text: '8', cb: cb),
            Button(text: '7', cb: cb),
            Button(text: '6', cb: cb),
            Button(text: '5', cb: cb),

            // Button.operation(text: '=', cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            Button(text: '4', cb: cb),
            Button(text: '3', cb: cb),
            Button(text: '2', cb: cb),
            Button(text: '1', cb: cb),
            Button(text: '0', cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            Button.big(text: 'C', color: Button.darkColor, cb: cb),
            Button.big(text: '<', delete: true, color: Button.darkColor, cb: cb),
            Button.big(text: '.', delete: false, color: Button.darkColor, cb: cb),
            Button.big(text: 'Enter', color: Button.darkColor, cb: cb),
            // Button(text: '<', color: Button.darkColor, cb: cb),
            // Button.operation(text: 'Enter', cb: cb),
          ]),
        ],
      ),
    );
  }
}

class InchKeyboard extends StatelessWidget {
  final void Function(String) cb;

  const InchKeyboard(this.cb, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 38.h,
      child: Column(
        children: <Widget>[
          ButtonRow([
            InchButton.big(text: '7', color: Button.darkColor, cb: cb),
            InchButton.big(text: '8', color: Button.darkColor, cb: cb),
            InchButton.big(text: '9', color: Button.darkColor, cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            InchButton.big(text: '4', color: Button.darkColor, cb: cb),
            InchButton.big(text: '5', color: Button.darkColor, cb: cb),
            InchButton.big(text: '6', color: Button.darkColor, cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            InchButton.big(text: '1', color: Button.darkColor, cb: cb),
            InchButton.big(text: '2', color: Button.darkColor, cb: cb),
            InchButton.big(text: '3', color: Button.darkColor, cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            InchButton.big(text: '0', color: Button.darkColor, cb: cb),
            InchButton.big(text: '.', color: Button.darkColor, cb: cb),
            InchButton.big(text: '<', delete: true, color: Button.darkColor, cb: cb),
          ]),
          const SizedBox(height: 1),
          ButtonRow([
            InchButton.big(text: 'C', color: Button.darkColor, cb: cb),
            InchButton.big(text: 'Enter', color: Button.darkColor, cb: cb),
          ]),
        ],
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final List buttons;

  const ButtonRow(this.buttons, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold(<Widget>[], (list, b) {
          list.isEmpty ? list.add(b) : list.addAll([const SizedBox(width: 1), b]);
          return list;
        }),
      ),
    );
  }
}

class Button extends StatelessWidget {
  static const darkColor = Color.fromRGBO(80, 102, 230, 1);
  static const defaultColor = Color.fromRGBO(63, 81, 181, 1);
  static const operationColor = Color.fromRGBO(33, 150, 243, 1);

  final String text;
  final String? num;
  final String? den;
  final bool big;
  final bool? delete;
  final Color color;
  final void Function(String) cb;

  const Button({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = false,
    this.delete,
    this.color = defaultColor,
    required this.cb,
  });

  const Button.big({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = true,
    this.delete,
    this.color = defaultColor,
    required this.cb,
  });

  const Button.operation({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = false,
    this.delete,
    this.color = operationColor,
    required this.cb,
  });

  const Button.delete({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = false,
    this.delete,
    this.color = operationColor,
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(), backgroundColor: Colors.white, padding: EdgeInsets.symmetric()),
        onPressed: () => cb(text),
        child: delete == true
            ? Image.asset(AppImage.delete, height: 20)
            : (num != null
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Text(num ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -60 * pi / 180,
                            child: Container(
                              width: 20,
                              height: 1,
                              color: Colors.black,
                              margin: EdgeInsets.symmetric(vertical: 2),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text(den ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  )
                : Text(
                    text,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
      ),
    );
  }
}

class InchButton extends StatelessWidget {
  static const darkColor = Color.fromRGBO(80, 102, 230, 1);
  static const defaultColor = Color.fromRGBO(63, 81, 181, 1);
  static const operationColor = Color.fromRGBO(33, 150, 243, 1);

  final String text;
  final String? num;
  final String? den;
  final bool big;
  final bool? delete;
  final Color color;
  final void Function(String) cb;

  const InchButton({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = false,
    this.delete,
    this.color = defaultColor,
    required this.cb,
  });

  const InchButton.big({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = true,
    this.delete,
    this.color = defaultColor,
    required this.cb,
  });

  const InchButton.operation({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = false,
    this.delete,
    this.color = operationColor,
    required this.cb,
  });

  const InchButton.delete({
    super.key,
    required this.text,
    this.num,
    this.den,
    this.big = false,
    this.delete,
    this.color = operationColor,
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(), backgroundColor: Colors.white, padding: EdgeInsets.symmetric()),
        onPressed: () => cb(text),
        child: delete == true
            ? Image.asset(AppImage.delete, height: 20)
            : (num != null
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Text(num ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -60 * pi / 180,
                            child: Container(
                              width: 20,
                              height: 1,
                              color: Colors.black,
                              margin: EdgeInsets.symmetric(vertical: 2),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text(den ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  )
                : Text(
                    text,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
      ),
    );
  }
}
