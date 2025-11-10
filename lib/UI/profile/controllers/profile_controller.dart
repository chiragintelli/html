import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hmtl/Services/api_services.dart';
import 'package:hmtl/Utils/utils.dart';

class ProfileController extends GetxController {
  RxString primaryCurrency = ''.obs;
  RxString primaryCurrencyCode = ''.obs;
  RxList selectedCurrency = [].obs;

  @override
  void onInit() {
    debugPrint('🔹 ProfileController onInit() called');
    fetchProfile();
    fetchCurrencyCountries();
    super.onInit();
  }

  List recommends = [
    'USD',
    'CAD',
    'INR',
    'GBP',
    'AED',
    'EUR',
    'AUD',
    'OMR',
    'QAR',
    'RUB',
    'CNY',
    'JPY',
  ];
  RxList suggestedList = [].obs;
  RxList filteredCountryList = [].obs;
  RxMap currencyDetails = {}.obs;

  void fetchCurrencyCountries() {
    debugPrint('🔹 fetchCurrencyCountries() started');
    ApiService()
        .getApi(
            url:
                'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes')
        .then((value) {
      if (value != null) {
        debugPrint('✅ Currency API fetched successfully');
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];

        debugPrint(
            '✅ Supported Codes Count: ${filteredCountryList.length.toString()}');

        for (var element in recommends) {
          try {
            suggestedList.add((currencyDetails['supported_codes'] as List)
                .where((e) => e[0] == element.toString())
                .first);
            debugPrint('⭐ Added to suggestedList: $element');
          } catch (e) {
            debugPrint('⚠️ $element not found in supported_codes');
          }
        }

        debugPrint('✅ Suggested list ready (${suggestedList.length} items)');
        debugPrint('SuggestedList Data: ${suggestedList.toString()}');
      } else {
        debugPrint('⚠️ Currency API returned null response');
      }
    }).catchError((e) {
      debugPrint('❌ Error in fetchCurrencyCountries(): $e');
    });
  }

  RxBool isFiltered = false.obs;

  void filterCurrencyList(String value) {
    debugPrint('🔹 filterCurrencyList() called with: "$value"');
    if (value.isEmpty) {
      debugPrint('ℹ️ Empty value received → Resetting list');
      resetList();
      isFiltered(false);
    } else {
      debugPrint(
          '🔍 Filtering currencies for keyword: "$value" from supported_codes');
      filteredCountryList.value = (currencyDetails['supported_codes'] as List)
          .where((element) =>
              element[0].toLowerCase().contains(value.toLowerCase()) ||
              element[1].toLowerCase().contains(value.toLowerCase()))
          .toList();
      debugPrint(
          '✅ Filtered results found: ${filteredCountryList.length.toString()}');
      isFiltered(true);
    }
  }

  void resetList() {
    debugPrint('🔹 resetList() called');
    filteredCountryList.value = currencyDetails['supported_codes'];
    debugPrint(
        '✅ filteredCountryList reset to ${filteredCountryList.length.toString()} items');
  }

  // void setCurrency(String value, String code) async {
  //   debugPrint('🔹 setCurrency() called with: $value ($code)');
  //   await StorageService.setStorage(key: 'primaryCurrency', value: value);
  //   await StorageService.setStorage(key: 'primaryCurrencyCode', value: code);
  //   debugPrint('✅ Currency saved locally: $value / $code');
  // }

  void setCurrency(String value, String code) async {
    debugPrint('🔹 setCurrency() called with: $value ($code)');

    // // existing lines
    // await StorageService.setStorage(key: 'primaryCurrency', value: value);
    // await StorageService.setStorage(key: 'primaryCurrencyCode', value: code);
    //
    // // 🆕 add this line to fix AED→INR fallback issue
    // await StorageService.setStorage(key: 'primaryCurrencyName', value: value);

    // Save the name and non-triggering keys FIRST
    await StorageService.setStorage(key: 'primaryCurrency', value: value);
    await StorageService.setStorage(key: 'primaryCurrencyName', value: value);

    // Save the key the listener is waiting for LAST
    await StorageService.setStorage(key: 'primaryCurrencyCode', value: code);

    debugPrint('✅ Saved currency in storage: $value ($code)');
  }

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userPhone = ''.obs;
  RxString userCompany = ''.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userCompanyController = TextEditingController();

  void fetchProfile() async {
    debugPrint('🔹 fetchProfile() started');
    var pc = await StorageService.getStorage(key: 'primaryCurrency');
    var pcc = await StorageService.getStorage(key: 'primaryCurrencyCode');

    if (pc != null) {
      debugPrint('✅ Found saved currency: $pc ($pcc)');
      primaryCurrencyCode.value = pcc;
      primaryCurrency.value = pc;
    } else {
      debugPrint('⚠️ No saved currency found, setting default (INR)');
      StorageService.setStorage(key: 'primaryCurrency', value: 'Indian Rupee');
      StorageService.setStorage(key: 'primaryCurrencyCode', value: 'INR');

      primaryCurrencyCode.value = 'INR';
      primaryCurrency.value = 'Indian Rupee';
    }

    userName.value = (await StorageService.getStorage(key: 'name')) ?? '';
    userEmail.value = (await StorageService.getStorage(key: 'email')) ?? '';
    userPhone.value = (await StorageService.getStorage(key: 'phone')) ?? '';
    userCompany.value = (await StorageService.getStorage(key: 'company')) ?? '';

    debugPrint(
        '✅ Profile loaded:\nName: ${userName.value}\nEmail: ${userEmail.value}\nPhone: ${userPhone.value}\nCompany: ${userCompany.value}');
  }

  RxBool editProfile = false.obs;

  void saveProfileDetails() {
    debugPrint('🔹 saveProfileDetails() called');
    StorageService.setStorage(key: 'name', value: userNameController.text);
    StorageService.setStorage(key: 'email', value: userEmailController.text);
    StorageService.setStorage(key: 'phone', value: userPhoneController.text);
    StorageService.setStorage(
        key: 'company', value: userCompanyController.text);
    editProfile(false);
    fetchProfile();
    debugPrint('✅ Profile Saved Successfully');
    Utils.showSnackBar(message: 'Profile Saved Successfully');
  }
}
