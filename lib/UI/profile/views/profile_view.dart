import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/UI/profile/controllers/profile_controller.dart';
import 'package:hmtl/Utils/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🔹 ProfileView build() called');
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              debugPrint('⬅️ Back button pressed');
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.white, size: 28)),
        backgroundColor: AppColor.primaryBlueColor,
        titleSpacing: 0,
        title: Text(
          'User Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Obx(() {
            debugPrint(
                '🔁 ProfileView Obx rebuild triggered (editProfile: ${controller.editProfile.value})');
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value
                        ? Expanded(
                            child: Text(
                                controller.userName.value.isNotEmpty
                                    ? controller.userName.value
                                    : 'Not Given',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          )
                        : Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                controller: controller.userNameController,
                                textAlign: TextAlign.end,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(right: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (value) {
                                  debugPrint('✏️ Name changed: $value');
                                  controller.userName.value = value;
                                },
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Email:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value
                        ? Expanded(
                            child: Text(
                                controller.userEmail.value.isNotEmpty
                                    ? controller.userEmail.value
                                    : 'Not Given',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          )
                        : Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                controller: controller.userEmailController,
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'User-Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(right: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (value) {
                                  debugPrint('✏️ Email changed: $value');
                                  controller.userEmail.value = value;
                                },
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Phone:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value
                        ? Expanded(
                            child: Text(
                                controller.userPhone.value.isNotEmpty
                                    ? controller.userPhone.value
                                    : 'Not Given',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          )
                        : Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                controller: controller.userPhoneController,
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'User-Phone',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(right: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (value) {
                                  debugPrint('✏️ Phone changed: $value');
                                  controller.userPhone.value = value;
                                },
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Company:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value
                        ? Expanded(
                            child: Text(
                                controller.userCompany.value.isNotEmpty
                                    ? controller.userCompany.value
                                    : 'Not Given',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          )
                        : Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                controller: controller.userCompanyController,
                                textAlign: TextAlign.end,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText: 'Company',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(right: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryBlueColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (value) {
                                  debugPrint('✏️ Company changed: $value');
                                  controller.userCompany.value = value;
                                },
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Primary Currency:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
                          debugPrint('💱 Opening currency selection dialog');
                          showDialog(
                            context: context,
                            builder: (context) {
                              debugPrint('💬 Currency dialog opened');
                              return MediaQuery.removeViewInsets(
                                context: context,
                                removeBottom: true,
                                child: Dialog(
                                  backgroundColor: Colors.white,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Obx(() {
                                      debugPrint(
                                          '🔁 Currency dialog rebuilding (isFiltered: ${controller.isFiltered.value})');
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
                                                      debugPrint(
                                                          '🔍 Currency search text: $value');
                                                      controller
                                                          .filterCurrencyList(
                                                              value);
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      hintText:
                                                          'Search Currency',
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
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              borderSide: BorderSide(
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
                                                              color: Colors.grey
                                                                  .shade400,
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
                                                              color: Colors.grey
                                                                  .shade400,
                                                              thickness: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                        controller.suggestedList
                                                            .length,
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
                                                                    debugPrint(
                                                                        '✅ Selected existing currency: ${country[0]}');
                                                                    controller
                                                                        .selectedCurrency
                                                                        .value = controller
                                                                            .suggestedList[
                                                                        index];
                                                                    Get.back();
                                                                  },
                                                                  title: Text(country[
                                                                          0] +
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
                                                                debugPrint(
                                                                    '💱 Currency selected from Popular: ${country[0]}');
                                                                controller
                                                                    .selectedCurrency
                                                                    .value = controller
                                                                        .suggestedList[
                                                                    index];
                                                                controller
                                                                        .primaryCurrency
                                                                        .value =
                                                                    controller
                                                                        .selectedCurrency[1];
                                                                controller
                                                                        .primaryCurrencyCode
                                                                        .value =
                                                                    controller
                                                                        .selectedCurrency[0];
                                                                controller.setCurrency(
                                                                    controller
                                                                        .selectedCurrency[
                                                                            1]
                                                                        .toString(),
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
                                                              color: Colors.grey
                                                                  .shade300,
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
                                                              color: Colors.grey
                                                                  .shade300,
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
                                                                  debugPrint(
                                                                      '✅ Selected existing currency (filtered): ${country[0]}');
                                                                  controller
                                                                      .selectedCurrency
                                                                      .value = controller
                                                                          .filteredCountryList[
                                                                      index];
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
                                                              debugPrint(
                                                                  '💱 Currency selected from All/Filtered: ${country[0]}');
                                                              controller
                                                                  .selectedCurrency
                                                                  .value = controller
                                                                      .filteredCountryList[
                                                                  index];
                                                              controller
                                                                  .primaryCurrency
                                                                  .value = controller
                                                                      .selectedCurrency[
                                                                  1];
                                                              controller
                                                                  .primaryCurrencyCode
                                                                  .value = controller
                                                                      .selectedCurrency[
                                                                  0];
                                                              controller.setCurrency(
                                                                  controller
                                                                      .selectedCurrency[
                                                                          1]
                                                                      .toString(),
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
                            debugPrint(
                                '❌ Currency dialog closed → Resetting list');
                            controller.resetList();
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          child: Text(
                            controller.primaryCurrency.value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    controller.editProfile.value
                        ? Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryRedColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {
                                debugPrint('💾 Save button clicked');
                                controller.saveProfileDetails();
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryRedColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {
                                debugPrint('✏️ Edit button clicked');
                                controller.userNameController.text =
                                    controller.userName.value;
                                controller.userEmailController.text =
                                    controller.userEmail.value;
                                controller.userPhoneController.text =
                                    controller.userPhone.value;
                                controller.userCompanyController.text =
                                    controller.userCompany.value;
                                controller.editProfile(true);
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
