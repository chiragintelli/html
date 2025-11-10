import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hmtl/Services/api_services.dart';
import 'package:hmtl/Utils/utils.dart';

class NpsController extends GetxController {
  List scheduleList = ['STD', 'XS'];

  late final GetStorage _box;
  late final VoidCallback _storageListener;

  @override
  void onInit() {
    debugPrint('🔹 NpsController onInit() called');
    fetchCurrencyCountries();
    readExcelFromAssets();

    _box = GetStorage();
    debugPrint('💾 GetStorage initialized');

    _loadPrimaryCurrency();

    _storageListener = _box.listenKey('primaryCurrencyCode', (newCode) {
      debugPrint('📢 Storage listener triggered with value: $newCode');
      if (newCode != null) {
        dev.log('Received storage update! New currency code: $newCode',
            name: 'NpsController.Listener');
        _loadPrimaryCurrency();
      }
    });

    super.onInit();
  }

  void _loadPrimaryCurrency() {
    debugPrint('🔸 _loadPrimaryCurrency() called');
    String? savedCode = _box.read('primaryCurrencyCode');
    String? savedName = _box.read('primaryCurrencyName');
    debugPrint('💾 Loaded values => Code: $savedCode | Name: $savedName');

    if (savedCode != null) {
      final nameToUse = savedName ?? savedCode;
      dev.log('Loading primary currency: $savedCode',
          name: 'NpsController._load');

      selectedCurrency.value = [savedCode, nameToUse];
      debugPrint('✅ Primary currency set: $savedCode - $nameToUse');

      if (savedCode == 'INR') {
        debugPrint('🇮🇳 Detected INR → setting exgRate = 1.0');
        textEditingControllerExgRate.text = '1.0';
        getRates(ex: '1.0');
      } else {
        debugPrint('🌍 Fetching currency details for $savedCode');
        fetchCurrencyDetails(savedCode);
      }
    } else {
      dev.log('No primary currency found, defaulting to INR',
          name: 'NpsController._load');
      debugPrint('⚠️ No currency found → using INR as default');
      selectedCurrency.value = ['INR', 'Indian Rupee'];
      textEditingControllerExgRate.text = '1.0';
    }
  }

  @override
  void onClose() {
    debugPrint('🔹 NpsController: onClose called, removing listener');
    dev.log('Disposing storage listener', name: 'NpsController');
    _storageListener();
    super.onClose();
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
    debugPrint('🌍 fetchCurrencyCountries() started');
    ApiService()
        .getApi(
            url:
                'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes')
        .then((value) {
      debugPrint('📡 fetchCurrencyCountries() response received');
      if (value != null) {
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];
        for (var element in recommends) {
          suggestedList.add((currencyDetails['supported_codes'] as List)
              .where((e) => e[0] == element.toString())
              .first);
        }
      }
    });
  }

  RxString selectedSchedule = ''.obs;
  RxString selectedNps = '1'.obs;
  TextEditingController controllerNps = TextEditingController();
  RxString odInch = ''.obs;
  RxString odMm = ''.obs;
  RxString thkInch = ''.obs;
  RxString thkMm = ''.obs;

  RxString kgM = ''.obs;
  RxString ssKgM = ''.obs;
  RxString kgFt = ''.obs;
  RxString lbsM = ''.obs;
  RxString lbsFt = ''.obs;

  RxDouble rate = 100.0.obs;
  RxDouble exgRate = 1.0.obs;

  TextEditingController textEditingControllerRateKg =
      TextEditingController(text: '0.0');
  TextEditingController textEditingControllerRateLbs =
      TextEditingController(text: '0.0');
  TextEditingController textEditingControllerExgRate =
      TextEditingController(text: '1.0');
  TextEditingController textEditingControllerRate =
      TextEditingController(text: '');

  // --- ADDED: Text Controllers for UI ---
  TextEditingController textEditingControllerOdMm =
      TextEditingController(text: '');
  TextEditingController textEditingControllerThkMm =
      TextEditingController(text: '');

  // ------------------------------------

  RxBool isFiltered = false.obs;

  void filterCurrencyList(String value) {
    debugPrint('🔹 filterCurrencyList called: $value');
    if (value.isEmpty) {
      debugPrint('🧭 Reset filter list');
      resetList();
      isFiltered(false);
    } else {
      filteredCountryList.value = (currencyDetails['supported_codes'] as List)
          .where((element) =>
              element[0].toLowerCase().contains(value.toLowerCase()) ||
              element[1].toLowerCase().contains(value.toLowerCase()))
          .toList();
      debugPrint('✅ Filtered list updated: ${filteredCountryList.length}');
      isFiltered(true);
    }
  }

  void resetList() {
    debugPrint('🔹 resetList() called');
    if (currencyDetails.isNotEmpty) {
      filteredCountryList.value = currencyDetails['supported_codes'];
      debugPrint('✅ Filtered list reset (${filteredCountryList.length})');
    }
  }

  RxBool loadingCurrency = false.obs;
  RxMap currencyMap = {}.obs;

  void fetchCurrencyDetails(String country) async {
    debugPrint('🌍 fetchCurrencyDetails() called for $country');
    var primaryCurrency =
        await StorageService.getStorage(key: 'primaryCurrencyCode') ?? 'INR';
    debugPrint('... against primary currency: $primaryCurrency');

    loadingCurrency(true);
    ApiService()
        .getApi(
            url:
                'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/latest/$country')
        .then((value) async {
      debugPrint('📡 fetchCurrencyDetails() response received');
      if (value != null) {
        var response = jsonDecode(value);
        currencyMap.value = response['conversion_rates'];
        textEditingControllerExgRate.text =
            double.parse(currencyMap[primaryCurrency].toString())
                .toStringAsFixed(2);
        exgRate.value = double.parse(currencyMap[primaryCurrency].toString());
        debugPrint('💹 Updated exgRate = ${exgRate.value}');
        loadingCurrency(false);
        getRates(ex: exgRate.value.toString());
      }
    });
  }

  RxBool isChanging = false.obs;
  RxBool isComputed = false.obs;

  void getRates({String? r, String? ex}) {
    debugPrint('💱 getRates() called with -> r:$r ex:$ex');
    if (r != null && r.isNotEmpty) {
      rate.value = Utils.parseToDouble(r);
      if (exgRate.value > 0) {
        textEditingControllerRateKg.text =
            (rate.value / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (rate.value / (exgRate.value * 2.205)).toStringAsFixed(2);
      } else {
        exgRate.value = 1;
        textEditingControllerRateKg.text =
            (rate.value / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (rate.value / (exgRate.value * 2.205)).toStringAsFixed(2);
      }
      debugPrint(
          '✅ getRates (by Rate) -> RateKg:${textEditingControllerRateKg.text} Lbs:${textEditingControllerRateLbs.text}');
    } else if (ex != null && ex.isNotEmpty) {
      exgRate.value = Utils.parseToDouble(ex);
      if (exgRate.value > 0) {
        textEditingControllerRateKg.text =
            (rate.value / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (rate.value / (exgRate.value * 2.205)).toStringAsFixed(2);
      } else {
        exgRate.value = 1;
        textEditingControllerRateKg.text =
            (rate.value / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (rate.value / (exgRate.value * 2.205)).toStringAsFixed(2);
      }
      debugPrint(
          '✅ getRates (by ExgRate) -> RateKg:${textEditingControllerRateKg.text} Lbs:${textEditingControllerRateLbs.text}');
    }

    if (textEditingControllerExgRate.text == '') {
      textEditingControllerExgRate.text = '1.0';
    }

    isChanging.toggle();
    debugPrint('🔁 isChanging toggled -> ${isChanging.value}');
  }

  void resetCalc() {
    debugPrint('🔄 resetCalc() called');
    selectedNps.value = '1';
    selectedSchedule.value = '';
    odInch.value = '';
    odMm.value = '';
    thkMm.value = '';
    thkInch.value = '';
    kgFt.value = '';
    kgM.value = '';
    ssKgM.value = '';
    lbsFt.value = '';
    lbsM.value = '';
    isComputed(false);
    textEditingControllerRateKg.text = '0.0';
    textEditingControllerRateLbs.text = '0.0';
    textEditingControllerRate.text = '';
    textEditingControllerExgRate.text = '1.0';

    // --- ADDED: Clear new controllers ---
    textEditingControllerOdMm.text = '';
    textEditingControllerThkMm.text = '';
    // ------------------------------------

    selectedCurrency.value = [];
    rate.value = 100.0;
    exgRate.value = 1.0;
    resetList();
    dev.log('Reset tapped. Re-loading primary currency.',
        name: 'NpsController.resetCalc');
    debugPrint('♻️ Reset done, reloading currency');
    _loadPrimaryCurrency();
  }

  void setNps() {
    odInch.value = selectedNps.value;
    odMm.value = Utils.parseToDouble(selectedNps.value.toString(), toMM: true)
        .toStringAsFixed(2);
  }

  Map globalNpsMap = {};

  Future<void> readExcelFromAssets() async {
    ByteData data = await rootBundle.load('assets/sheets/nps.xlsx');
    Uint8List bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      var rows = excel.tables[table]!.rows;

      for (var row in rows) {
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
        String lbsM =
            (double.parse((kgM.isNotEmpty && kgM != ' ') ? kgM : '1.0') *
                    2.20462262)
                .toStringAsFixed(2);
        String kgFt =
            (double.parse((kgM.isNotEmpty && kgM != ' ') ? kgM : '1.0') /
                    3.2808)
                .toStringAsFixed(2);
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
      }
    }
    debugPrint('✅ Excel data loaded into globalNpsMap');
  }

  void calculateValue() {
    debugPrint('⚙️ calculateValue() called');
    if (selectedSchedule.value.isEmpty) {
      debugPrint('⚠️ No schedule selected, aborting calculation.');
      return;
    }

    isComputed.value = true;
    dev.log(
        'Computing values for ${selectedNps.value} - ${selectedSchedule.value}',
        name: 'NpsController.Calc');

    var map = (globalNpsMap[selectedNps.value] as List)
        .where((element) => element['schedule'] == selectedSchedule.value)
        .first;

    thkInch.value = map['thkInch'];
    thkMm.value = map['thkMm'];
    odInch.value = map['odInch'];
    odMm.value = map['odMm'];

    // --- ADDED: Populate Text Controllers ---
    textEditingControllerOdMm.text = odMm.value;
    textEditingControllerThkMm.text = thkMm.value;
    // ------------------------------------

    kgM.value = map['kgM']; // This is CS kg/m
    kgFt.value = map['kgFt'];
    lbsM.value = map['lbsM'];
    lbsFt.value = map['lbsFt'];

    double csKgM = Utils.parseToDouble(kgM.value);
    ssKgM.value = (csKgM * 1.02002311).toStringAsFixed(2);
    debugPrint('📏 Calculated CS kg/m = ${kgM.value}');
    debugPrint('📏 Calculated SS kg/m = ${ssKgM.value}');

    getRates(
        r: textEditingControllerRate.text.isEmpty
            ? '100.0'
            : textEditingControllerRate.text,
        ex: textEditingControllerExgRate.text);
    debugPrint('💹 Called getRates() after calculation');
  }
}
