import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/UI/profile/controllers/profile_controller.dart';
import 'package:hmtl/Utils/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.white, size: 28)),
        backgroundColor: AppColor.primaryBlueColor,
        titleSpacing: 0,
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        // height: 420,
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Obx(() {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value?
                    Text(controller.userName.value.isNotEmpty?controller.userName.value:'Not Given',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)):
                    Expanded(
                      child: SizedBox(
                        // color: Colors.amber,
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
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
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
                    Text(
                      'Email:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value?
                    Text(controller.userEmail.value.isNotEmpty?controller.userEmail.value:'Not Given',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)):
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: controller.userEmailController,
                          textAlign: TextAlign.end,
                          // textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'User-Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.only(right: 10),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
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
                    Text(
                      'Phone number:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value?
                    Text(controller.userPhone.value.isNotEmpty?controller.userPhone.value:'Not Given',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)):
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: controller.userPhoneController,
                          textAlign: TextAlign.end,
                          // textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'User-Phone',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.only(right: 10),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
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
                    Text(
                      'Company name:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20),
                    !controller.editProfile.value?
                    Text(controller.userCompany.value.isNotEmpty?controller.userCompany.value:'Not Given',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)):
                    Expanded(
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
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
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
                                                                    print('object ${controller.selectedCurrency}');

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
                                                                controller.selectedCurrency.value = controller.suggestedList[index];

                                                                // print('object ${controller.selectedCurrency.value}');
                                                                controller.primaryCurrency.value = controller.selectedCurrency[1];
                                                                controller.primaryCurrencyCode.value = controller.selectedCurrency[0];
                                                                controller.setCurrency(controller.selectedCurrency[1].toString(),controller.selectedCurrency[0].toString());
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
                                                                  print('object ${controller.selectedCurrency.value}');

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

                                                              // print('object ${controller.selectedCurrency.value}');
                                                              controller.primaryCurrency.value = controller.selectedCurrency[1];
                                                              controller.primaryCurrencyCode.value = controller.selectedCurrency[0];
                                                              controller.setCurrency(controller.selectedCurrency[1].toString(), controller.selectedCurrency[0].toString());
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
                            controller.resetList();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          // decoration: BoxDecoration(
                          //   color: Colors.grey.shade300,
                          //   borderRadius: BorderRadius.circular(6)
                          // ),
                          child: Text(
                            controller.primaryCurrency.value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    controller.editProfile.value?
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryRedColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
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
                    ):
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryRedColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          controller.userNameController.text = controller.userName.value;
                          controller.userEmailController.text = controller.userEmail.value;
                          controller.userPhoneController.text = controller.userPhone.value;
                          controller.userCompanyController.text = controller.userCompany.value;
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
