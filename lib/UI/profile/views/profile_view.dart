import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmtl/UI/profile/controllers/profile_controller.dart';
import 'package:hmtl/Utils/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget _buildLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildViewField(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  // 🎨 UI Helper for text fields in "Edit Mode"
  Widget _buildEditField(
    TextEditingController fieldController,
    String hintText,
    Function(String) onChanged,
    TextInputType keyboardType, {
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization capitalization = TextCapitalization.none,
    TextInputAction action = TextInputAction.next,
  }) {
    // We use the exact same decoration logic (border colors) from your original
    // but apply it to a cleaner, standard OutlineInputBorder.
    return TextFormField(
      inputFormatters: inputFormatters ?? [],
      controller: fieldController,

      validator: validator,

      // Changed to 'start' to match the new label-over-field UI
      textAlign: TextAlign.start,
      textCapitalization: capitalization,
      keyboardType: keyboardType,
      textInputAction: action,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // Preserving your original border styling logic
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryBlueColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
      ),
      // Preserving your exact onChanged logic
      onChanged: onChanged,
    );
  }

  // 🎨 UI Helper for the currency picker in "Edit Mode"
  Widget _buildCurrencyPicker(BuildContext context) {
    return InkWell(
      // Preserving your exact onTap and showDialog logic
      onTap: () {
        debugPrint('💱 Opening currency selection dialog');
        showDialog(
          context: context,
          builder: (context) {
            debugPrint('💬 Currency dialog opened');
            // Your entire dialog logic is copied here, unchanged
            return MediaQuery.removeViewInsets(
              context: context,
              removeBottom: true,
              child: Dialog(
                backgroundColor: Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(children: [
                            Text(
                              'Exchange Currency',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColor.whiteColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SizedBox(
                                height: 40,
                                child: TextField(
                                  onChanged: (value) {
                                    debugPrint(
                                        '🔍 Currency search text: $value');
                                    controller.filterCurrencyList(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    hintText: 'Search Currency',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                if (!controller.isFiltered.value) ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Divider(
                                            color: Colors.grey.shade400,
                                            thickness: 1,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Popular Currencies',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                        var country =
                                            controller.suggestedList[index];
                                        if (country.isNotEmpty) {
                                          if (controller
                                              .selectedCurrency.isNotEmpty) {
                                            if (controller
                                                    .selectedCurrency[0] ==
                                                country[0]) {
                                              return ListTile(
                                                minTileHeight: 40,
                                                onTap: () {
                                                  debugPrint(
                                                      '✅ Selected existing currency: ${country[0]}');
                                                  controller.selectedCurrency
                                                          .value =
                                                      controller
                                                          .suggestedList[index];
                                                  Get.back();
                                                },
                                                title: Text(country[0] +
                                                    ' - ' +
                                                    country[1]),
                                                trailing: Icon(
                                                    Icons.check_circle,
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
                                                      .selectedCurrency.value =
                                                  controller
                                                      .suggestedList[index];
                                              controller.primaryCurrency.value =
                                                  controller
                                                      .selectedCurrency[1];
                                              controller.primaryCurrencyCode
                                                      .value =
                                                  controller
                                                      .selectedCurrency[0];
                                              controller.setCurrency(
                                                  controller.selectedCurrency[1]
                                                      .toString(),
                                                  controller.selectedCurrency[0]
                                                      .toString());
                                              Get.back();
                                            },
                                            title: Text(country[0] +
                                                ' - ' +
                                                country[1]),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Divider(
                                            color: Colors.grey.shade400,
                                            thickness: 1,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'All Currencies',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Divider(
                                            color: Colors.grey.shade400,
                                            thickness: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  const SizedBox(height: 10)
                                ],
                                Column(
                                  children: List.generate(
                                    controller.filteredCountryList.length,
                                    (index) {
                                      var country =
                                          controller.filteredCountryList[index];
                                      if (country.isNotEmpty) {
                                        if (controller
                                            .selectedCurrency.isNotEmpty) {
                                          if (controller.selectedCurrency[0] ==
                                              country[0]) {
                                            return ListTile(
                                              minTileHeight: 40,
                                              onTap: () {
                                                debugPrint(
                                                    '✅ Selected existing currency: ${country[0]}');
                                                controller.selectedCurrency
                                                        .value =
                                                    controller
                                                            .filteredCountryList[
                                                        index];
                                                Get.back();
                                              },
                                              title: Text(country[0] +
                                                  ' - ' +
                                                  country[1]),
                                              trailing: Icon(Icons.check_circle,
                                                  color:
                                                      AppColor.primaryBlueColor,
                                                  size: 25),
                                            );
                                          }
                                        }

                                        return ListTile(
                                          minTileHeight: 40,
                                          onTap: () {
                                            debugPrint(
                                                '💱 Currency selected from All: ${country[0]}');
                                            controller.selectedCurrency.value =
                                                controller
                                                    .filteredCountryList[index];
                                            controller.primaryCurrency.value =
                                                controller.selectedCurrency[1];
                                            controller
                                                    .primaryCurrencyCode.value =
                                                controller.selectedCurrency[0];
                                            controller.setCurrency(
                                                controller.selectedCurrency[1]
                                                    .toString(),
                                                controller.selectedCurrency[0]
                                                    .toString());
                                            Get.back();
                                          },
                                          title: Text(
                                              country[0] + ' - ' + country[1]),
                                        );
                                      } else {
                                        return const SizedBox();
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
            // End of your dialog logic
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // Using your blue border to show it's "editable"
          border: Border.all(color: AppColor.primaryBlueColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.primaryCurrencyCode.value.isNotEmpty
                  ? controller.primaryCurrencyCode.value
                  : 'Select Currency',
              style: TextStyle(
                fontSize: 16,
                color: controller.primaryCurrencyCode.value.isNotEmpty
                    ? Colors.black87
                    : Colors.grey.shade600,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔹 ProfileView build() called');
    return Scaffold(
      // A cleaner, "idler" AppBar that blends with the background
      appBar: AppBar(
        leading: GestureDetector(
          // Preserving your exact back button logic
          onTap: () {
            debugPrint('⬅️ Back button pressed');
            Get.back();
          },
          child: Icon(Icons.arrow_back,
              color: AppColor.primaryBlueColor, size: 28),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'User Profile',
          style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ),
      // Use SingleChildScrollView to prevent overflow and remove nested Containers
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          // Preserving your exact Obx and debugPrint logic
          debugPrint(
              '🔁 ProfileView Obx rebuild triggered (editProfile: ${controller.editProfile.value})');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Name ---
              _buildLabel('Name'),
              const SizedBox(height: 8),
              !controller.editProfile.value
                  ? _buildViewField(controller.userName.value.isNotEmpty
                      ? controller.userName.value
                      : 'Not Given')
                  : _buildEditField(
                      controller.userNameController,
                      'Username',
                      // Preserving your exact onChanged logic
                      (value) {
                        debugPrint('✏️ Name changed: $value');
                        controller.userName.value = value;
                      },
                      TextInputType.name,
                      capitalization: TextCapitalization.words,
                      action: TextInputAction.next,
                    ),
              const SizedBox(height: 24),

              // --- Email ---
              _buildLabel('Email'),
              const SizedBox(height: 8),
              !controller.editProfile.value
                  ? _buildViewField(controller.userEmail.value.isNotEmpty
                      ? controller.userEmail.value
                      : 'Not Given')
                  : _buildEditField(
                      controller.userEmailController,
                      'User-Email',
                      // Preserving your exact onChanged logic
                      (value) {
                        debugPrint('✏️ Email changed: $value');
                        controller.userEmail.value = value;
                      },
                      TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
              const SizedBox(height: 24),

              // --- Phone ---
              _buildLabel('Phone'),
              const SizedBox(height: 8),
              !controller.editProfile.value
                  ? _buildViewField(controller.userPhone.value.isNotEmpty
                      ? controller.userPhone.value
                      : 'Not Given')
                  : _buildEditField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],

                      controller.userPhoneController,
                      'User-Phone',
                      // Preserving your exact onChanged logic
                      (value) {
                        debugPrint('✏️ Phone changed: $value');
                        controller.userPhone.value = value;
                      },
                      TextInputType.number,
                      action: TextInputAction.next,
                    ),
              const SizedBox(height: 24),

              // --- Company ---
              _buildLabel('Company'),
              const SizedBox(height: 8),
              !controller.editProfile.value
                  ? _buildViewField(controller.userCompany.value.isNotEmpty
                      ? controller.userCompany.value
                      : 'Not Given')
                  : _buildEditField(
                      controller.userCompanyController,
                      'Company',
                      // Preserving your exact onChanged logic
                      (value) {
                        debugPrint('✏️ Company changed: $value');
                        controller.userCompany.value = value;
                      },
                      TextInputType.name,
                      capitalization: TextCapitalization.words,
                      action: TextInputAction.done,
                    ),
              const SizedBox(height: 24),

              // --- Primary Currency ---
              _buildLabel('Primary Currency'),
              const SizedBox(height: 8),
              !controller.editProfile.value
                  ? _buildViewField(
                      controller.primaryCurrencyCode.value.isNotEmpty
                          ? controller.primaryCurrencyCode.value
                          : 'Not Set')
                  : _buildCurrencyPicker(context),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  // Preserving your exact style logic
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),

                  onPressed: () {
                    debugPrint(
                        "🟢 BUTTON PRESSED, current = ${controller.editProfile.value}");

                    if (controller.editProfile.value == false) {
                      // ✏️ Switch to edit mode
                      debugPrint("✏️ Switching to EDIT MODE");

                      // 🟢 IMPORTANT FIX — fill controllers with saved data
                      controller.userNameController.text =
                          controller.userName.value;
                      controller.userEmailController.text =
                          controller.userEmail.value;
                      controller.userPhoneController.text =
                          controller.userPhone.value;
                      controller.userCompanyController.text =
                          controller.userCompany.value;

                      controller.editProfile.value = true;
                    } else {
                      // 💾 Save
                      debugPrint("💾 Saving profile...");
                      controller.saveProfileDetails();
                      controller.editProfile.value = false;
                    }

                    debugPrint(
                        "🔵 AFTER button action: ${controller.editProfile.value}");
                  },

                  // Preserving your exact text-toggle logic
                  child: Text(
                    controller.editProfile.value
                        ? 'Save Profile'
                        : 'Edit Profile',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
