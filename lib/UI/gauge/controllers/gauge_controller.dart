import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmtl/Services/api_services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hmtl/Utils/utils.dart';

class GaugeController extends GetxController {

  List odList = [
    '1/4',
    '1/2',
    '5/8',
    '3/4',
    '1',
    '1 1/4',
    '1 1/2',
    '1 3/4',
    '2',
    '2 1/4',
    '2 1/2',
    '3',
    '3 1/4',
    '3 1/2',
    '4',
    '4 1/4',
    '4 1/2',
    '5',
    '5 1/4',
    '5 1/2',
    '5 3/4',
    '6',
    '6 1/4',
    '6 1/2',
    '6 3/4',
    '7',
    '7 1/4',
    '7 1/2',
    '7 3/4',
    '8',
    '8 1/4',
    '8 1/2',
    '8 3/4',
    '9',
    '9 1/4',
    '9 1/2',
    '9 3/4',
    '10',
    '10 1/4',
    '10 1/2',
    '10 3/4',
    '11',
    '12',
    '14',
    '16',
    '18',
    '20',
    '22',
    '24',
    '26',
    '28',
    '30',
    '32',
    '34',
    '36',
    '38',
    '40',
    '42',
    '44',
    '46',
    '48'
  ];

  List odListMm = [
    "6.35", "12.70", "15.88", "19.05", "25.40", "31.75", "38.10", "44.45",
    "50.80", "57.14", "63.50", "76.20", "82.55", "88.90", "101.60", "107.95",
    "114.30", "127.00", "133.35", "139.70", "146.05", "152.40", "158.75", "165.10",
    "171.45", "177.80", "184.15", "190.50", "196.85", "203.20", "209.55", "215.90",
    "222.25", "228.60", "234.95", "241.30", "247.65", "254.00", "260.35", "266.70",
    "273.05", "279.40"
  ];

  List gaugeThickness = [
    '35 SWG',
    '35 BWG',
    '34 SWG',
    '34 BWG',
    '33 SWG',
    '33 BWG',
    '32 SWG',
    '32 BWG',
    '31 SWG',
    '31 BWG',
    '30 SWG',
    '30 BWG',
    '29 SWG',
    '29 BWG',
    '28 SWG',
    '28 BWG',
    '27 SWG',
    '27 BWG',
    '26 SWG',
    '26 BWG',
    '25 SWG',
    '25 BWG',
    '24 SWG',
    '24 BWG',
    '23 SWG',
    '23 BWG',
    '22 SWG',
    '22 BWG',
    '21 SWG',
    '21 BWG',
    '20 SWG',
    '20 BWG',
    '19 SWG',
    '19 BWG',
    '18 SWG',
    '18 BWG',
    '17 SWG',
    '17 BWG',
    '16 SWG',
    '16 BWG',
    '15 SWG',
    '15 BWG',
    '14 SWG',
    '14 BWG',
    '13 SWG',
    '13 BWG',
    '12 SWG',
    '12 BWG',
    '11 SWG',
    '11 BWG',
    '10 SWG',
    '10 BWG',
    '9 SWG',
    '9 BWG',
    '8 SWG',
    '8 BWG',
    '7 SWG',
    '7 BWG',
    '6 SWG',
    '6 BWG',
    '5 SWG',
    '5 BWG',
    '4 SWG',
    '4 BWG',
    '3 SWG',
    '3 BWG',
    '2 SWG',
    '2 BWG',
    '1 SWG',
    '1 BWG',
  ];

  List wallThicknessList = [
    "0.203",
    "0.127",
    "0.229",
    "0.178",
    "0.254",
    "0.203",
    "0.279",
    "0.229",
    "0.305",
    "0.254",
    "0.305",
    "0.305",
    "0.356",
    "0.33",
    "0.381",
    "0.356",
    "0.406",
    "0.406",
    "0.457",
    "0.457",
    "0.508",
    "0.508",
    "0.559",
    "0.559",
    "0.61",
    "0.635",
    "0.711",
    "0.711",
    "0.813",
    "0.813",
    "0.914",
    "0.889",
    "1.016",
    "1.067",
    "1.22",
    "1.25",
    "1.422",
    "1.499",
    "1.63",
    "1.65",
    "1.829",
    "1.829",
    "2.03",
    "2.11",
    "2.337",
    "2.413",
    "2.64",
    "2.77",
    "2.946",
    "3.048",
    "3.25",
    "3.40",
    "3.66",
    "3.76",
    "4.06",
    "4.20",
    "4.47",
    "4.57",
    "4.87",
    "5.156",
    "5.385",
    "5.588",
    "5.893",
    "6.045",
    "6.401",
    "6.579",
    "7.01",
    "7.214",
    "7.62",
    "7.62",
  ];

  @override
  void onInit() {
    // Future.delayed(Duration(milliseconds: 800),() {
    //   focusNodeOd.requestFocus();
    // });
    setGauge();
    fetchCurrencyCountries();
    super.onInit();
  }

  RxDouble kgm = 0.0.obs;
  RxDouble ckgm = 0.0.obs;

  RxString selectedOD = ''.obs;
  RxString selectedThickness = ''.obs;
  // TextEditingController textEditingControllerOd = TextEditingController(text: '--');
  TextEditingController textEditingControllerOdMm = TextEditingController(text: '');
  TextEditingController textEditingControllerThkMm = TextEditingController(text: '');
  TextEditingController textEditingControllerRate = TextEditingController(text: '');
  TextEditingController textEditingControllerExgRate = TextEditingController(text: '');
  TextEditingController textEditingControllerRateKg = TextEditingController(text: '');
  TextEditingController textEditingControllerRateLbs = TextEditingController(text: '');

  Map globalGaugeMap = {};

  void setGauge() async {
    ByteData data = await rootBundle.load('assets/sheets/gauge.xlsx');
    Uint8List bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print('Sheet: $table');
      var rows = excel.tables[table]!.rows;

      for (int i = 0; i < rows.length; i++) {
        if (i == 0) {
          print(rows[i].map((cell) => cell?.value.toString() ?? ' ').toList());
        } else if (i == 1) {}
      }
      for (var row in rows) {
        print('Row --${row[0]?.value}-- ${row.map((cell) => cell?.value.toString() ?? ' ').toList()}');

        print('-----------------------------------------------------------------------------------------------------');
      }

      return;
    }
  }

  void calculateValue() {

    if(selectedOD.isEmpty){
      return;
    }

    if(selectedThickness.isEmpty) {
      return;
    }

    String thicknessMm;
    print('selectedThickness ${selectedThickness.value}');
    if(selectedThickness.contains('SWG')) {
      var thick = Utils.parseToDouble(selectedThickness.value.replaceAll('SWG', '').replaceAll(' ', ''));
      thicknessMm = wallThicknessList.reversed.elementAt((2*thick.toInt())-1);
      // print('thickkkk === ${}');
    } else {
      var thick = Utils.parseToDouble(selectedThickness.value.replaceAll('BWG', '').replaceAll(' ', ''));
      thicknessMm = wallThicknessList.reversed.elementAt((2*thick.toInt())-2);
      // print('thickkkk === ${}');
    }

    // textEditingControllerOd.text = double(selectedOD);
    textEditingControllerOdMm.text = odListMm[odList.indexOf(selectedOD.value)];
    // textEditingControllerThk.text = '';
    textEditingControllerThkMm.text = thicknessMm;

    kgm.value = (Utils.parseToDouble(textEditingControllerOdMm.text)-Utils.parseToDouble(textEditingControllerThkMm.text))*Utils.parseToDouble(textEditingControllerThkMm.text)*0.0246615;
    ckgm.value = (Utils.parseToDouble(textEditingControllerOdMm.text)-Utils.parseToDouble(textEditingControllerThkMm.text))*Utils.parseToDouble(textEditingControllerThkMm.text)*0.0251550;

  }

  RxBool isFiltered = false.obs;
  void filterCurrencyList(String value) {
    if(value.isEmpty){
      resetList();
      isFiltered(false);
    }else{
      print(currencyDetails['supported_codes']);
      print('---1--');
      filteredCountryList.value = (currencyDetails['supported_codes'] as List).where((element) => element[1].toLowerCase().contains(value.toLowerCase())).toList();
      isFiltered(true);
    }
  }

  void resetList() {
    filteredCountryList.value = currencyDetails['supported_codes'];
  }

  void resetCalc() {
    selectedOD.value = '';
    selectedThickness.value = '';
    kgm.value = 0.0;
    ckgm.value = 0.0;
    isComputed(false);
    textEditingControllerRate.text = '';
    textEditingControllerExgRate.text = '';
    textEditingControllerOdMm.text = '';
    textEditingControllerThkMm.text = '';
    textEditingControllerRateKg.text = '';
    textEditingControllerRateLbs.text = '';
    selectedCurrency.value = [];
    rate.value = 100.0;
    exgRate.value = 1.0;
  }

  RxDouble rate = 100.0.obs;
  RxDouble exgRate = 1.0.obs;
  RxBool changing = false.obs;
  void getRates({String? r, String? ex}) {

    computeRate();

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

  RxBool isComputed = false.obs;
  computeRate(){

    if(selectedOD.value.isEmpty){
      return;
    }
    if(selectedThickness.value.isEmpty){
      return;
    }
    isComputed.value = true;


    if(textEditingControllerExgRate.text==''){
      textEditingControllerExgRate.text = '1.00';
    }

    if(textEditingControllerRate.text==''){
      textEditingControllerRate.text = '100';
    }
  }

  RxBool loadingCurrency = false.obs;
  RxMap currencyMap = {}.obs;
  RxDouble convertAmountToInr = 0.0.obs;
  void fetchCurrencyDetails(String country) {
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
  void fetchCurrencyCountries() {
    // loadingCurrency(true);

    ApiService().getApi(url: 'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes').then((value) {
      if (value != null) {
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
}
