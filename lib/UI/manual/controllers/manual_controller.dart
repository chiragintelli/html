import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/Services/api_services.dart';
import 'package:hmtl/Utils/utils.dart';

// fname, lname, email id, phone number, primary currency
class ManualController extends GetxController {

  final List<String> units = ["mm", "Inch"];
  RxInt selectedUnitIndex = 0.obs;

  FocusNode focusNodeOd = FocusNode();
  FocusNode focusNodeId = FocusNode();
  FocusNode focusNodeThk = FocusNode();

  TextEditingController textEditingControllerOd = TextEditingController();
  TextEditingController textEditingControllerId = TextEditingController();
  TextEditingController textEditingControllerThk = TextEditingController();
  TextEditingController textEditingControllerRateKg = TextEditingController(text: '0.0');
  TextEditingController textEditingControllerRateLbs = TextEditingController(text: '0.0');
  TextEditingController textEditingControllerExgRate = TextEditingController(text: '1.0');

  var odTextList = [];
  var idTextList = [];
  var thkTextList = [];

  RxDouble rate = 100.0.obs;
  RxDouble exgRate = 1.0.obs;
  // RxDouble rateKg = 0.0.obs;
  // RxDouble rateLbs = 0.0.obs;

  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: 800),() {
      focusNodeOd.requestFocus();
    });
    fetchCurrencyCountries();
    super.onInit();
  }

  void enterValue(String value) {

    print('id $idTextList');
    print('od $odTextList');
    print('thk $thkTextList');

    if(value=='Enter'){
      if(focusNodeOd.hasFocus){
        focusNodeOd.nextFocus();
      }
      else if(focusNodeId.hasFocus){
        focusNodeId.nextFocus();
      }
      else if(focusNodeThk.hasFocus){
        focusNodeThk.nextFocus();
      }
      // calculateValue();
      return;
    }
    if(value=='C'){
      if(focusNodeOd.hasFocus){
        odTextList.clear();
        textEditingControllerOd.clear();
      }
      else if(focusNodeId.hasFocus){
        idTextList.clear();
        textEditingControllerId.clear();
      }
      else if(focusNodeThk.hasFocus){
        thkTextList.clear();
        textEditingControllerThk.clear();
      }
      return;
    }
    if(value=='<'){
      if(focusNodeOd.hasFocus){
        if(odTextList.isNotEmpty){
          odTextList.removeLast();
          textEditingControllerOd.text = odTextList.join(' ');
        }else{
          textEditingControllerOd.text = '';
        }
        return;
      }
      else if(focusNodeId.hasFocus){
        if(idTextList.isNotEmpty){
          idTextList.removeLast();
          textEditingControllerId.text = idTextList.join(' ');
        }else{
          textEditingControllerId.text = '';
        }
        return;
      }
      else if(focusNodeThk.hasFocus){
        if(thkTextList.isNotEmpty){
          thkTextList.removeLast();
          textEditingControllerThk.text = thkTextList.join(' ');
          return;
        }else{
          textEditingControllerThk.text = '';
        }
      }
      return;
    }
    if(focusNodeOd.hasFocus){
      if(textEditingControllerOd.text.isEmpty){
        odTextList.add(value);

        textEditingControllerOd.text = value;
      }else{
        if(value.contains('/')){
          odTextList.add(value);
        }else{
          if(odTextList.last.toString().contains('/')) {
            odTextList.add(value);
          } else {
            odTextList.last = '${odTextList.last}$value';
          }
        }
      }

      if(idTextList.isNotEmpty && thkTextList.isEmpty){
        var thk = (Utils.parseToDouble(odTextList.join(' ')) - Utils.parseToDouble(idTextList.join(' ')))/2;
        textEditingControllerThk.text = thk.toStringAsFixed(2);
      }
      else if(thkTextList.isNotEmpty){
        var id = Utils.parseToDouble(odTextList.join(' ')) - Utils.parseToDouble(thkTextList.join(' '))*2;
        textEditingControllerId.text = id.toStringAsFixed(2);
      }
      // focusNodeOd.nextFocus();
      textEditingControllerOd.text = odTextList.join(' ');

      return;
    }
    else if(focusNodeId.hasFocus) {
      if(textEditingControllerId.text.isEmpty) {
        idTextList.add(value);
      } else {
        if(value.contains('/')){
          idTextList.add(value);
        }else{
          if(idTextList.last.toString().contains('/')) {
            idTextList.add(value);
          } else {
            idTextList.last = '${idTextList.last}$value';
          }
        }
      }

      if(thkTextList.isNotEmpty && odTextList.isEmpty){
        var od = Utils.parseToDouble(idTextList.join(' ')) + Utils.parseToDouble(thkTextList.join(' '))*2;
        textEditingControllerOd.text = od.toStringAsFixed(2);

      } else if(odTextList.isNotEmpty){
        var thk = (Utils.parseToDouble(odTextList.join(' ')) - Utils.parseToDouble(idTextList.join(' ')))/2;
        textEditingControllerThk.text = thk.toStringAsFixed(2);
      }
      // focusNodeOd.nextFocus();
      textEditingControllerId.text = idTextList.join(' ');

    }
    else if(focusNodeThk.hasFocus){

      if(textEditingControllerThk.text.isEmpty){
        thkTextList.add(value);

        textEditingControllerThk.text = value;
      } else {
        if(value.contains('/')) {
          thkTextList.add(value);
        } else {
          if(thkTextList.last.toString().contains('/')) {
            thkTextList.add(value);
          } else {
            thkTextList.last = '${thkTextList.last}$value';
          }
        }
      }

      if(odTextList.isEmpty && idTextList.isNotEmpty){
        var od = Utils.parseToDouble(idTextList.join(' ')) + (Utils.parseToDouble(thkTextList.join(' '))*2);
        textEditingControllerOd.text = od.toStringAsFixed(2);
      } else if(odTextList.isNotEmpty){
        var id = Utils.parseToDouble(odTextList.join(' ')) - (Utils.parseToDouble(thkTextList.join(' '))*2);

        print('od - ${Utils.parseToDouble(odTextList.join(' '))}');
        print('thk - ${Utils.parseToDouble(thkTextList.join(' '))}');
        textEditingControllerId.text = id.toStringAsFixed(2);
      }
      // focusNodeOd.nextFocus();
      textEditingControllerThk.text = thkTextList.join(' ');


      return;
    }

    print('object123321 $idTextList');
  }

  RxBool changing = false.obs;
  RxBool isComputed = false.obs;
  RxDouble kgm = 0.0.obs;
  RxDouble ckgm = 0.0.obs;

  void calculateValue() {
    isComputed(true);
    kgm.value = (Utils.parseToDouble(textEditingControllerOd.text,toMM: selectedUnitIndex.value==1)-Utils.parseToDouble(textEditingControllerThk.text,toMM: selectedUnitIndex.value==1))*Utils.parseToDouble(textEditingControllerThk.text,toMM: selectedUnitIndex.value==1)*0.0246615;
    print('kg/m  - $kgm');
    print('kg/ft - ${kgm/3.2808}');
    print('lbs/m - ${kgm*2.2046226}');
    print('lbs/feet - ${(kgm*2.2046226)/3.2808}');
    print(textEditingControllerId.text.substring(textEditingControllerId.text.length - 3));

    print('CS---');

    ckgm.value = (Utils.parseToDouble(textEditingControllerOd.text,toMM: selectedUnitIndex.value==1)-Utils.parseToDouble(textEditingControllerThk.text,toMM: selectedUnitIndex.value==1))*Utils.parseToDouble(textEditingControllerThk.text,toMM: selectedUnitIndex.value==1)*0.0251550;
    print('kg/m $ckgm');
    print('kg/ft - ${ckgm/3.2808}');
    print('lbs/m - ${ckgm*2.2046226}');
    print('lbs/feet - ${(ckgm*2.2046226)/3.2808}');

    changing.toggle();
  }

  void resetCalc() {
    textEditingControllerOd.clear();
    textEditingControllerId.clear();
    textEditingControllerThk.clear();
    textEditingControllerRateKg.text = '0.0';
    textEditingControllerRateLbs.text = '0.0';
    textEditingControllerExgRate.text = '1.0';
    odTextList.clear();
    idTextList.clear();
    thkTextList.clear();
    selectedCurrency.value = [];
    exgRate.value = 1;
    isComputed(false);
    resetList();
    rate.value = 100.0;
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
  RxList selectedCurrency = [].obs;

  //https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json' -- Unli
  //https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/latest/USD -- 1500

  RxBool isFiltered = false.obs;
  void filterCurrencyList(String value) {
    if(value.isEmpty){
      resetList();
      isFiltered(false);
    }else{
      print(currencyDetails['supported_codes']);
      print('---1--');
      filteredCountryList.value = (currencyDetails['supported_codes'] as List).where((element) => element[0].toLowerCase().contains(value.toLowerCase()) || element[1].toLowerCase().contains(value.toLowerCase())).toList();
      isFiltered(true);
    }
  }

  void getRates({String? r, String? ex}) {
    if (r != null && r.isNotEmpty) {
      if (exgRate.value > 0) {
        textEditingControllerRateKg.text = (Utils.parseToDouble(r) / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text = (Utils.parseToDouble(r) / (exgRate.value * 2.205)).toStringAsFixed(2);
        rate.value = Utils.parseToDouble(r);
      } else {
        exgRate.value = 1;
      }
    } else if (ex != null && ex.isNotEmpty) {
      if (Utils.parseToDouble(ex) > 0) {
        textEditingControllerRateKg.text = (rate.value / Utils.parseToDouble(ex)).toStringAsFixed(2);
        textEditingControllerRateLbs.text = (rate.value / (Utils.parseToDouble(ex) * 2.205)).toStringAsFixed(2);
        exgRate.value = Utils.parseToDouble(ex);
      } else {
        exgRate.value = 1;
      }
    }
    changing.toggle();
    // setState(() {});
    // print('KG - ${controller.textEditingControllerRateKg.text}');
    // print('LBS - ${controller.textEditingControllerRateKg.text}');
  }

  void resetList() {
    filteredCountryList.value = currencyDetails['supported_codes'];
  }

  void fetchCurrencyCountries() {
    // loadingCurrency(true);
    ApiService().getApi(url: 'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes').then((value) {
      if(value!=null){
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];

        for (var element in recommends) {
          suggestedList.add((currencyDetails['supported_codes'] as List).where((e) => e[0]==element.toString()).first);
        }

        // print('object ${countriesList.map((e) => e[1]).toList()}');
        // textEditingControllerExgRate.text = double.parse(currencyDetails[country]['inr'].toString()).toStringAsFixed(2);
        // exgRate.value = double.parse(currencyDetails[country]['inr'].toString());
        // loadingCurrency(false);
        // calculateValue();
      }
    });
  }

  //GET https://v6.exchangerate-api.com/v6/YOUR-API-KEY/codes
  RxBool loadingCurrency = false.obs;
  RxMap currencyMap = {}.obs;
  RxDouble convertAmountToInr = 0.0.obs;
  void fetchCurrencyDetails(String country) async {
    print('object90 ${await StorageService.getStorage(key: 'primaryCurrencyCode')}');
    loadingCurrency(true);
    ApiService().getApi(url: 'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/latest/$country').then((value) async {
      if(value!=null){
        var response = jsonDecode(value);
        currencyMap.value = response['conversion_rates'];
        textEditingControllerExgRate.text = double.parse(currencyMap[await StorageService.getStorage(key: 'primaryCurrencyCode')].toString()).toStringAsFixed(2);
        exgRate.value = double.parse(currencyMap[await StorageService.getStorage(key: 'primaryCurrencyCode')].toString());
        loadingCurrency(false);
        getRates(ex: exgRate.value.toString());
      }
    });
  }
}