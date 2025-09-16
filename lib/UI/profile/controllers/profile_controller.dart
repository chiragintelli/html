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
    // loadingCurrency(true);
    // USD
    // CAD
    // INR
    // POUND
    // EUR
    // AED
    // RIAL
    // Qatar rial
    // aus dollar
    // rubal
    // china
    // russiun
    // japanease

    ApiService().getApi(url: 'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes').then((value) {
      if (value != null) {
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];
        for (var element in recommends) {
          suggestedList.add((currencyDetails['supported_codes'] as List).where((e) => e[0]==element.toString()).first);
        }
        print('asd $suggestedList');
        // print('object ${countriesList.map((e) => e[1]).toList()}');
        // textEditingControllerExgRate.text = double.parse(currencyDetails[country]['inr'].toString()).toStringAsFixed(2);
        // exgRate.value = double.parse(currencyDetails[country]['inr'].toString());
        // loadingCurrency(false);
        // calculateValue();
      }
    });
  }

  RxBool isFiltered = false.obs;
  void filterCurrencyList(String value) {
    if(value.isEmpty) {
      resetList();
      isFiltered(false);
    } else {
      print(currencyDetails['supported_codes']);
      filteredCountryList.value = (currencyDetails['supported_codes'] as List).where((element) => element[0].toLowerCase().contains(value.toLowerCase()) || element[1].toLowerCase().contains(value.toLowerCase())).toList();
      isFiltered(true);
    }
  }

  void resetList() {
    filteredCountryList.value = currencyDetails['supported_codes'];
  }

  void setCurrency(String value, String code) async {
    StorageService.setStorage(key: 'primaryCurrency', value: value);
    StorageService.setStorage(key: 'primaryCurrencyCode', value: code);
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
    var pc = await StorageService.getStorage(key: 'primaryCurrency');
    var pcc = await StorageService.getStorage(key: 'primaryCurrencyCode');

    if(pc!=null) {
      primaryCurrencyCode.value = pcc;
      primaryCurrency.value = pc;
    } else {
      StorageService.setStorage(key: 'primaryCurrency', value: 'Indian Rupee');
      StorageService.setStorage(key: 'primaryCurrencyCode', value: 'INR');

      primaryCurrencyCode.value = 'INR';
      primaryCurrency.value = 'Indian Rupee';
    }

    userName.value = (await StorageService.getStorage(key: 'name'))??'';
    userEmail.value = (await StorageService.getStorage(key: 'email'))??'';
    userPhone.value = (await StorageService.getStorage(key: 'phone'))??'';
    userCompany.value = (await StorageService.getStorage(key: 'company'))??'';
  }

  RxBool editProfile = false.obs;

  void saveProfileDetails() {
    StorageService.setStorage(key: 'name', value: userNameController.text);
    StorageService.setStorage(key: 'email', value: userEmailController.text);
    StorageService.setStorage(key: 'phone', value: userPhoneController.text);
    StorageService.setStorage(key: 'company', value: userCompanyController.text);
    editProfile(false);
    fetchProfile();

    Utils.showSnackBar(message: 'Profile Saved Successfully');
  }

}