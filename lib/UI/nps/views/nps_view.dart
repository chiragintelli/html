import 'dart:developer' as dev; // <-- ADDED

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // <-- ADDED
import 'package:hmtl/Services/app_routes.dart';
import 'package:hmtl/UI/manual/views/manual_view.dart';
import 'package:hmtl/UI/nps/controllers/nps_controller.dart';
import 'package:hmtl/Utils/app_colors.dart';
import 'package:hmtl/Utils/app_strings.dart';
import 'package:hmtl/Utils/utils.dart';

class NpsView extends StatefulWidget {
  const NpsView({super.key});

  @override
  State<NpsView> createState() => _NpsViewState();
}

class _NpsViewState extends State<NpsView> {
  NpsController controller = Get.put(NpsController());

  // --- ADDED: initState logic from ManualView ---
  @override
  void initState() {
    super.initState();
    dev.log('NpsView initState fired', name: 'NpsView.initState');
    final box = GetStorage();
    String? savedCode = box.read('primaryCurrencyCode');
    String? savedName = box.read('primaryCurrencyName');

    if (savedCode != null && savedName != null) {
      dev.log('Loaded primary currency from storage: $savedCode',
          name: 'NpsView.initState');
      controller.selectedCurrency.value = [savedCode, savedName];

      if (savedCode == 'INR') {
        controller.textEditingControllerExgRate.text = '1.0';
        controller.getRates(ex: '1.0');
      } else {
        controller.fetchCurrencyDetails(savedCode);
      }
    } else {
      dev.log('No primary currency found, defaulting to INR',
          name: 'NpsView.initState');
      if (controller.selectedCurrency.isEmpty) {
        controller.selectedCurrency.value = ['INR', 'Indian Rupee'];
        controller.textEditingControllerExgRate.text = '1.0';
      }
    }
  }

  // ------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.currencyDetails.value;
      return Column(children: [
        Container(
          decoration: BoxDecoration(color: AppColor.primaryBlueColor),
          // width: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Pipe Specifications',
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
                  dev.log('Tapped Profile Icon', name: 'NpsView.Tap');
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
              Container(
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
                                      child: Column(
                                        children: [
                                          Text(
                                            'NPS Value',
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
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.grey)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8)),
                                                    ),
                                                    height: 50,
                                                    child: TextField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              prefixIcon: Icon(
                                                                  Icons.search,
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
                                                    child: ListView.separated(
                                                      itemCount: controller
                                                          .globalNpsMap.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                          onTap: () {
                                                            controller
                                                                    .selectedNps
                                                                    .value =
                                                                controller
                                                                    .globalNpsMap
                                                                    .keys
                                                                    .elementAt(
                                                                        index);
                                                            Get.back();
                                                          },
                                                          minTileHeight: 25,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                          title: Container(
                                                            child: Text(
                                                                '${controller.globalNpsMap.keys.elementAt(index)}'),
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) =>
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
                                      ),
                                    ),
                                  );
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
                                        'NPS',
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                controller.selectedNps.value
                                                        .isNotEmpty
                                                    ? controller
                                                        .selectedNps.value
                                                    : 'Select Value',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 28)
                                          ])
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Schedule',
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton2(
                                            value: controller.selectedSchedule
                                                    .value.isEmpty
                                                ? null
                                                : ((controller.globalNpsMap[
                                                            controller
                                                                .selectedNps
                                                                .value] as List)
                                                        .any((element) =>
                                                            element['schedule']
                                                                .toString() ==
                                                            controller
                                                                .selectedSchedule
                                                                .value
                                                                .toString()))
                                                    ? controller
                                                        .selectedSchedule.value
                                                    : null,
                                            iconStyleData: IconStyleData(
                                              icon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    size: 28),
                                              ),
                                            ),
                                            isExpanded: true,
                                            items: controller
                                                    .globalNpsMap.isNotEmpty
                                                ? (controller.globalNpsMap[
                                                        controller.selectedNps
                                                            .value] as List)
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                            value:
                                                                e['schedule'],
                                                            child: Text(e[
                                                                    'schedule']
                                                                .toString())))
                                                    .toList()
                                                : [],
                                            onChanged: (value) {
                                              controller.selectedSchedule
                                                  .value = value.toString();
                                            },
                                            isDense: true,
                                            underline: SizedBox(),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10)),
                                            buttonStyleData: ButtonStyleData(
                                                height: 30,
                                                decoration: BoxDecoration(),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0)),
                                            hint: Text('Select Value',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                      dev.log('Tapped Let\'s Compute', name: 'NpsView.Tap');
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
                      dev.log('Tapped Reset', name: 'NpsView.Tap');
                      controller.resetCalc();
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

              // --- MODIFIED: Show tables only after compute ---
              if (controller.isComputed.value) ...[
                // This is the Row with OD/THK text fields
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        enabled: false,
                        // USE NPS CONTROLLER'S VARIABLE
                        controller: controller.textEditingControllerOdMm,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'OD (mm)',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: '--',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: TextField(
                          // USE NPS CONTROLLER'S VARIABLE
                          controller: controller.textEditingControllerThkMm,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelText: 'THK (mm)',
                            border: InputBorder.none,
                            hintText: '--',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        ),
                      ),
                    ),
                  )
                ]),
                SizedBox(height: 20),
                // This is the CS/SS Table
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
                                height: 40,
                                child: Center(
                                    child: Text(' ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(
                                    child: Text('kg/m',
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(
                                    child: Text('kg/ft',
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(
                                    child: Text('lbs/m',
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)))),
                          ),
                          TableCell(
                            child: Container(
                                color: AppColor.primaryBlueColor,
                                height: 40,
                                child: Center(
                                    child: Text('lbs/feet',
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)))),
                          ),
                        ],
                      ),
                      TableRow(
                          // CS Row
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            TableCell(
                              child: Container(
                                  color: Colors.red,
                                  height: 40,
                                  child: Center(
                                      child: Text('CS',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // CS kg/m
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          // Parse the RxString value from NpsController
                                          Utils.parseToDouble(
                                                  controller.kgM.value)
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // CS kg/ft
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          (Utils.parseToDouble(
                                                      controller.kgM.value) /
                                                  3.2808) // Calculate
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // CS lbs/m
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          (Utils.parseToDouble(
                                                      controller.kgM.value) *
                                                  2.2046226) // Calculate
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // CS lbs/feet
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          ((Utils.parseToDouble(controller
                                                          .kgM.value) *
                                                      2.2046226) / // Calculate
                                                  3.2808)
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                          ]),
                      TableRow(
                          // SS Row
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          children: [
                            TableCell(
                              child: Container(
                                  color: Colors.red,
                                  height: 40,
                                  child: Center(
                                      child: Text('SS',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // SS kg/m
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          // Parse the RxString value from NpsController
                                          Utils.parseToDouble(
                                                  controller.ssKgM.value)
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // SS kg/ft
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          (Utils.parseToDouble(
                                                      controller.ssKgM.value) /
                                                  3.2808) // Calculate
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // SS lbs/m
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          (Utils.parseToDouble(
                                                      controller.ssKgM.value) *
                                                  2.2046226) // Calculate
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              // SS lbs/feet
                              child: SizedBox(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          ((Utils.parseToDouble(controller
                                                          .ssKgM.value) *
                                                      2.2046226) / // Calculate
                                                  3.2808)
                                              .toStringAsFixed(2),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                          ]),
                    ],
                  ),
                ),
                // ---------------- END OF REPLACED BLOCK -----------------
                SizedBox(height: 20),

                // --- ADDED: Rate Fields (from ManualView) ---
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        controller: controller.textEditingControllerRate,
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
                          dev.log('Rate TextField onChanged: $value',
                              name: 'Input.Rate');
                          controller.getRates(r: value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        dev.log('Tapped to open Exchange Currency dialog',
                            name: 'UI.Tap');
                        showDialog(
                          context: context,
                          builder: (context) {
                            return MediaQuery.removeViewInsets(
                              context: context,
                              removeBottom: true,
                              child: Dialog(
                                backgroundColor: Colors.white,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Obx(() {
                                    dev.log(
                                        'Currency Dialog Obx rebuilding. isFiltered: ${controller.isFiltered.value}',
                                        name: 'UI.Dialog');
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryBlueColor,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: SizedBox(
                                                height: 40,
                                                child: TextField(
                                                  onChanged: (value) {
                                                    dev.log(
                                                        'Currency Search onChanged: $value',
                                                        name:
                                                            'Input.DialogSearch');
                                                    controller
                                                        .filterCurrencyList(
                                                            value);
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    hintText: 'Search Currency',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              children: [
                                                if (!controller
                                                    .isFiltered.value) ...[
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Divider(
                                                            color: Colors
                                                                .grey.shade400,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Popular Currencies',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Divider(
                                                            color: Colors
                                                                .grey.shade400,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: List.generate(
                                                      controller
                                                          .suggestedList.length,
                                                      (index) {
                                                        var country = controller
                                                                .suggestedList[
                                                            index];
                                                        if (country
                                                            .isNotEmpty) {
                                                          if (controller
                                                              .selectedCurrency
                                                              .isNotEmpty) {
                                                            if (controller
                                                                        .selectedCurrency[
                                                                    0] ==
                                                                country[0]) {
                                                              return ListTile(
                                                                minTileHeight:
                                                                    40,
                                                                onTap: () {
                                                                  dev.log(
                                                                      'Tapped Popular (Selected): ${country[0]}',
                                                                      name:
                                                                          'UI.DialogTap');
                                                                  controller
                                                                      .selectedCurrency
                                                                      .value = controller
                                                                          .suggestedList[
                                                                      index];
                                                                  controller.fetchCurrencyDetails(
                                                                      controller
                                                                          .selectedCurrency[
                                                                              0]
                                                                          .toString());
                                                                  Get.back();
                                                                },
                                                                title: Text(
                                                                    country[0] +
                                                                        ' - ' +
                                                                        country[
                                                                            1]),
                                                                trailing: Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color: AppColor
                                                                        .primaryBlueColor,
                                                                    size: 25),
                                                              );
                                                            }
                                                          }

                                                          return ListTile(
                                                            minTileHeight: 40,
                                                            onTap: () {
                                                              dev.log(
                                                                  'Tapped Popular (New): ${country[0]}',
                                                                  name:
                                                                      'UI.DialogTap');
                                                              controller
                                                                  .selectedCurrency
                                                                  .value = controller
                                                                      .suggestedList[
                                                                  index];
                                                              controller.fetchCurrencyDetails(
                                                                  controller
                                                                      .selectedCurrency[
                                                                          0]
                                                                      .toString());
                                                              Get.back();
                                                            },
                                                            title: Text(
                                                                country[0] +
                                                                    ' - ' +
                                                                    country[1]),
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Divider(
                                                            color: Colors
                                                                .grey.shade300,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'All',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Divider(
                                                            color: Colors
                                                                .grey.shade300,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                Column(
                                                  children: List.generate(
                                                    controller
                                                        .filteredCountryList
                                                        .length,
                                                    (index) {
                                                      var country = controller
                                                              .filteredCountryList[
                                                          index];
                                                      if (country.isNotEmpty) {
                                                        if (controller
                                                            .selectedCurrency
                                                            .isNotEmpty) {
                                                          if (controller
                                                                      .selectedCurrency[
                                                                  0] ==
                                                              country[0]) {
                                                            return ListTile(
                                                              minTileHeight: 40,
                                                              onTap: () {
                                                                dev.log(
                                                                    'Tapped Filtered (Selected): ${country[0]}',
                                                                    name:
                                                                        'UI.DialogTap');
                                                                controller
                                                                    .selectedCurrency
                                                                    .value = controller
                                                                        .filteredCountryList[
                                                                    index];
                                                                controller.fetchCurrencyDetails(
                                                                    controller
                                                                        .selectedCurrency[
                                                                            0]
                                                                        .toString());
                                                                Get.back();
                                                              },
                                                              title: Text(
                                                                  country[0] +
                                                                      ' - ' +
                                                                      country[
                                                                          1]),
                                                              trailing: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: AppColor
                                                                      .primaryBlueColor,
                                                                  size: 25),
                                                            );
                                                          }
                                                        }

                                                        return ListTile(
                                                          minTileHeight: 40,
                                                          onTap: () {
                                                            dev.log(
                                                                'Tapped Filtered (New): ${country[0]}',
                                                                name:
                                                                    'UI.DialogTap');
                                                            controller
                                                                .selectedCurrency
                                                                .value = controller
                                                                    .filteredCountryList[
                                                                index];
                                                            controller.fetchCurrencyDetails(
                                                                controller
                                                                    .selectedCurrency[
                                                                        0]
                                                                    .toString());
                                                            Get.back();
                                                          },
                                                          title: Text(
                                                              country[0] +
                                                                  ' - ' +
                                                                  country[1]),
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
                          dev.log('Currency Dialog closed. Resetting filter.',
                              name: 'UI.Dialog');
                          controller.isFiltered(false);
                          controller.resetList();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: controller.loadingCurrency.value
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : TextField(
                                controller:
                                    controller.textEditingControllerExgRate,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
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
                              ),
                      ),
                    ),
                  )
                ]),
                SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        enabled: false,
                        controller: controller.textEditingControllerRateKg,
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
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        enabled: false,
                        controller: controller.textEditingControllerRateLbs,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
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
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20),

                // --- ADDED: Final Calculation Table (from ManualView) ---
                Obx(() {
                  // This Obx rebuilds when 'isChanging' toggles
                  dev.log('--- Obx Table Rebuilding ---', name: 'Table.Calc');
                  dev.log(
                      'Trigger: controller.isChanging.value = ${controller.isChanging.value}',
                      name: 'Table.Calc');

                  // Parse values
                  final double rateKg = Utils.parseToDouble(
                      controller.textEditingControllerRateKg.text);
                  final double rateLbs = Utils.parseToDouble(
                      controller.textEditingControllerRateLbs.text);
                  final double csKgm =
                      Utils.parseToDouble(controller.kgM.value);
                  final double ssKgm =
                      Utils.parseToDouble(controller.ssKgM.value);

                  dev.log('Parsed [rateKg]: $rateKg', name: 'Table.Calc');
                  dev.log('Parsed [rateLbs]: $rateLbs', name: 'Table.Calc');
                  dev.log('Parsed [csKgm]: $csKgm', name: 'Table.Calc');
                  dev.log('Parsed [ssKgm]: $ssKgm', name: 'Table.Calc');

                  // Calculate final values
                  final double csRatePerMeter = csKgm * rateKg;
                  final double csRatePerFeet = (csKgm / 3.2808) * rateKg;
                  final double ssRatePerMeter = ssKgm * rateLbs * 2.2046226;
                  final double ssRatePerFeet =
                      (ssKgm / 3.2808) * rateLbs * 2.2046226;

                  dev.log('CS Rate/Meter = $csKgm * $rateKg = $csRatePerMeter',
                      name: 'Table.Calc');
                  dev.log(
                      'SS Rate/Meter = $ssKgm * $rateLbs * 2.20... = $ssRatePerMeter',
                      name: 'Table.Calc');

                  return Container(
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
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                          controller.selectedCurrency.isNotEmpty
                                              ? "In ${controller.selectedCurrency[0].toString()}"
                                              : 'In INR',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              child: Container(
                                  color: AppColor.primaryBlueColor,
                                  height: 40,
                                  child: Center(
                                      child: Text('Rate/Meter',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                            TableCell(
                              child: Container(
                                  color: AppColor.primaryBlueColor,
                                  height: 40,
                                  child: Center(
                                      child: Text('Rate/feet',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))),
                            ),
                          ],
                        ),
                        TableRow(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            children: [
                              TableCell(
                                child: Container(
                                    color: Colors.red,
                                    height: 40,
                                    child: Center(
                                        child: Text('CS',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)))),
                              ),
                              TableCell(
                                child: SizedBox(
                                    height: 40,
                                    child: Center(
                                        child: Text(
                                            csRatePerMeter.toStringAsFixed(2),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)))),
                              ),
                              TableCell(
                                child: SizedBox(
                                    height: 40,
                                    child: Center(
                                        child: Text(
                                            csRatePerFeet.toStringAsFixed(2),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)))),
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
                                    height: 40,
                                    child: Center(
                                        child: Text('SS',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)))),
                              ),
                              TableCell(
                                child: SizedBox(
                                    height: 40,
                                    child: Center(
                                        child: Text(
                                            ssRatePerMeter.toStringAsFixed(2),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)))),
                              ),
                              TableCell(
                                child: SizedBox(
                                    height: 40,
                                    child: Center(
                                        child: Text(
                                            ssRatePerFeet.toStringAsFixed(2),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)))),
                              ),
                            ]),
                      ],
                    ),
                  );
                })
              ]
            ],
          ),
        ),
      ]);
    });
  }
}
