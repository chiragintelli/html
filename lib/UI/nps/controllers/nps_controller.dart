import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:hmtl/Services/api_services.dart';
import 'package:hmtl/Utils/utils.dart';

class NpsController extends GetxController {

  List scheduleList = ['STD', 'XS'];

  @override
  void onInit() {
    // Future.delayed(Duration(milliseconds: 800),() {
    //   focusNodeOd.requestFocus();
    // });
    fetchCurrencyCountries();
    readExcelFromAssets();
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
  RxList selectedCurrency = [].obs;

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
  // RxDouble kgm = 0.0.obs;
  // RxDouble ckgm = 0.0.obs;

  RxString selectedSchedule = ''.obs;
  RxString selectedNps = '1'.obs;
  TextEditingController controllerNps = TextEditingController();
  RxString odInch = ''.obs;
  RxString odMm = ''.obs;
  RxString thkInch = ''.obs;
  RxString thkMm = ''.obs;

  RxString kgM = ''.obs;
  RxString kgFt = ''.obs;
  RxString lbsM = ''.obs;
  RxString lbsFt = ''.obs;

  RxDouble rate = 100.0.obs;
  RxDouble exgRate = 1.0.obs;

  TextEditingController textEditingControllerRateKg = TextEditingController(text: '');
  TextEditingController textEditingControllerRateLbs = TextEditingController(text: '');
  TextEditingController textEditingControllerExgRate = TextEditingController(text: '');
  // TextEditingController textEditingControllerThkMm = TextEditingController(text: '--');
  TextEditingController textEditingControllerRate = TextEditingController(text: '');

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

  RxBool isChanging = false.obs;
  RxBool isComputed = false.obs;
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

    if(textEditingControllerExgRate.text==''){
      textEditingControllerExgRate.text = '1.0';
    }

    isChanging.toggle();
    // setState(() {});
    // print('KG - ${controller.textEditingControllerRateKg.text}');
    // print('LBS - ${controller.textEditingControllerRateKg.text}');
  }

  void resetCalc() {
    selectedNps.value = '1';
    selectedSchedule.value = '';
    odInch.value = '';
    odMm.value = '';
    thkMm.value = '';
    thkInch.value = '';
    kgFt.value = '';
    kgM.value = '';
    lbsFt.value = '';
    lbsM.value = '';
    isComputed(false);
    textEditingControllerRateKg.text = '';
    textEditingControllerRateLbs.text = '';
    textEditingControllerRate.text = '';
    textEditingControllerExgRate.text = '';
    selectedCurrency.value = [];
    rate.value = 100.0;
    exgRate.value = 1.0;
  }

  void setNps() {
    odInch.value = selectedNps.value;
    odMm.value = Utils.parseToDouble(selectedNps.value.toString(), toMM: true).toStringAsFixed(2);
  }

  Map globalNpsMap = {};
  Future<void> readExcelFromAssets() async {
    ByteData data = await rootBundle.load('assets/sheets/nps.xlsx');
    Uint8List bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print('Sheet: $table');
      var rows = excel.tables[table]!.rows;

      for (var row in rows) {
        // print('Row --${row.length}-- ${row.map((cell) => cell?.value.toString() ?? ' ').toList()}');

        String nps = row[0]?.value.toString() ?? '';
        String schedule = row[4]?.value.toString() ?? '';

        String odMm = row[6]?.value.toString() ?? '';
        String thkMm = row[7]?.value.toString() ?? '';
        String odInch = row[9]?.value.toString() ?? '';
        String thkInch = row[10]?.value.toString() ?? '';

        String kgM = row[8]?.value.toString() ?? '';
        if (double.tryParse(kgM) == null) {
          continue;
        }
        String lbsM = (double.parse((kgM.isNotEmpty && kgM != ' ') ? kgM : '1.0') * 2.20462262).toStringAsFixed(2);
        String kgFt = (double.parse((kgM.isNotEmpty && kgM != ' ') ? kgM : '1.0') / 3.2808).toStringAsFixed(2);
        String lbsFt = (double.parse(lbsM) / 3.2808).toStringAsFixed(2);

        if (globalNpsMap[nps.toString()] != null) {
          (globalNpsMap[nps.toString()] as List).add({
            'schedule': schedule,
            'odMm': odMm,
            'thkMm': thkMm,
            'odInch': odInch,
            'thkInch': thkInch,
            'kgM': kgM,
            'lbsM': lbsM,
            'kgFt': kgFt,
            'lbsFt': lbsFt,
          });
        } else {
          globalNpsMap[nps.toString()] = [
            {
              'schedule': schedule,
              'odMm': odMm,
              'thkMm': thkMm,
              'odInch': odInch,
              'thkInch': thkInch,
              'kgM': kgM,
              'lbsM': lbsM,
              'kgFt': kgFt,
              'lbsFt': lbsFt,
            }
          ];
        }

        print('NPS: $nps, Schedule: $schedule --- Od(mm): $odMm Thk(mm): $thkMm OD(Inch): $odInch Thk(Inch): $thkInch === KgM: $kgM LbsM: $lbsM KgFt: $kgFt LbsFt: $lbsFt');
        print('-----------------------------------------------------------------------------------------------------');
      }
    }
  }

  void calculateValue() {

    if(selectedSchedule.value.isEmpty){
      return;
    }

    isComputed.value = true;

    var map = (globalNpsMap[selectedNps.value] as List)
        .where((element) => element['schedule'] == selectedSchedule.value)
        .first;

    print('object $map');
    thkInch.value = map['thkInch'];
    thkMm.value = map['thkMm'];
    odInch.value = map['odInch'];
    odMm.value = map['odMm'];

    kgM.value = map['kgM'];
    kgFt.value = map['kgFt'];
    lbsM.value = map['lbsM'];
    lbsFt.value = map['lbsFt'];
  }
}
