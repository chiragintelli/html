import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/Services/app_routes.dart';
import 'package:hmtl/UI/chemical/controllers/chemical_controller.dart';
import 'package:hmtl/UI/manual/views/manual_view.dart';
import 'package:hmtl/Utils/app_colors.dart';
import 'package:hmtl/Utils/app_strings.dart';
import 'package:sizer/sizer.dart';

class ChemicalView extends GetView<ChemicalController> {
  const ChemicalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.selectedGrade.value; // Listen for selection changes

      return Column(children: [
        Container(
          decoration: BoxDecoration(color: AppColor.primaryBlueColor),
          width: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Opacity(
                  opacity: 0,
                  child: Icon(
                    Icons.account_box_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 20,
                    ),
                    Text(
                      'Chemical Units',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter pipe dimensions to calculate weights and costs',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.find<MainController>().currentPage.value = 2;
                  Get.toNamed(AppRoutes.profile);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
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
                              SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Obx(() {
                                        return Column(
                                          children: [
                                            Text(
                                              'Specification Grade Value',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Expanded(
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.grey)),
                                                child: controller
                                                        .globalChemicalMap
                                                        .isEmpty
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8)),
                                                            ),
                                                            height: 50,
                                                            child: TextField(
                                                              // --- MODIFIED: Connected Controller and onChanged ---
                                                              controller: controller
                                                                  .searchController,
                                                              onChanged: (value) =>
                                                                  controller
                                                                      .filterChemicalList(
                                                                          value),
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .center,
                                                              decoration: InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  prefixIcon: Icon(
                                                                      Icons
                                                                          .search,
                                                                      size: 20),
                                                                  hintText:
                                                                      'Search...',
                                                                  filled: false,
                                                                  fillColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  enabledBorder:
                                                                      InputBorder
                                                                          .none),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: ListView
                                                                .separated(
                                                              // itemCount: controller
                                                              //     .globalChemicalMap
                                                              //     .length,
                                                              itemCount: controller
                                                                  .filteredChemicalMap
                                                                  .length,

                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                String grade = controller
                                                                    .filteredChemicalMap
                                                                    .keys
                                                                    .elementAt(
                                                                        index);
                                                                return ListTile(
                                                                  onTap: () {
                                                                    controller
                                                                        .selectedGrade
                                                                        .value = grade;
                                                                    Get.back();
                                                                  },
                                                                  minTileHeight:
                                                                      25,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  title: Text(
                                                                      grade),
                                                                );
                                                              },
                                                              separatorBuilder: (context,
                                                                      index) =>
                                                                  Container(
                                                                      height: 1,
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    ),
                                  ).then((_) {
                                    // --- ADDED: Reset search when modal is closed ---
                                    controller.resetSearch();
                                    // ------------------------------------------------
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Specification-Grade',
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  controller.selectedGrade.value
                                                          .isNotEmpty
                                                      ? controller
                                                          .selectedGrade.value
                                                      : 'Select Value',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 28)
                                          ])
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(height: 15),
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
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Table(
                  border: TableBorder(
                    horizontalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                    verticalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      children: [
                        TableCell(
                          child: SizedBox(
                              // color: Colors.red,
                              height: 40,
                              child: Center(
                                  child: Text('%C',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                '%Mn',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%P',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%S',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%Si',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                      ],
                    ),
                    TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          TableCell(
                            child: SizedBox(
                                // color: Colors.red,
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%C']
                                                .toString()
                                            : '--',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Mn']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%P']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%S']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Si']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Table(
                  border: TableBorder(
                    horizontalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                    verticalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      children: [
                        TableCell(
                          child: SizedBox(
                              // color: Colors.red,
                              height: 40,
                              child: Center(
                                  child: Text('%Cr',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                '%Cu',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%Mo',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%Ni',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%V',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                      ],
                    ),
                    TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          TableCell(
                            child: SizedBox(
                                // color: Colors.red,
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Cr']
                                                .toString()
                                            : '--',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Cu']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Mo']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Ni']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%V']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Table(
                  border: TableBorder(
                    horizontalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                    verticalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      children: [
                        TableCell(
                          child: SizedBox(
                              // color: Colors.red,
                              height: 40,
                              child: Center(
                                  child: Text('%B',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                '%Nb',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%N',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%Al',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%Ti',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                      ],
                    ),
                    TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          TableCell(
                            child: SizedBox(
                                // color: Colors.red,
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%B']
                                                .toString()
                                            : '--',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Nb']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%N']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Al']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%TI']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Table(
                  border: TableBorder(
                    horizontalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                    verticalInside:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      children: [
                        TableCell(
                          child: SizedBox(
                              // color: Colors.red,
                              height: 40,
                              child: Center(
                                  child: Text('%Zr',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Hardness',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('Y.S',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('U.T.S',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                        TableCell(
                          child: SizedBox(
                              height: 40,
                              child: Center(
                                  child: Text('%E',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey)))),
                        ),
                      ],
                    ),
                    TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          TableCell(
                            child: SizedBox(
                                // color: Colors.red,
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%Zr']
                                                .toString()
                                            : '--',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['Hardness']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['Y.S.']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['U.T.S.']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                          TableCell(
                            child: SizedBox(
                                height: 40,
                                child: Center(
                                    child: Text(
                                        controller
                                                .selectedGrade.value.isNotEmpty
                                            ? controller.globalChemicalMap[
                                                    controller.selectedGrade
                                                        .value]['%E']
                                                .toString()
                                            : '--',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)))),
                          ),
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]);
    });
  }
}
