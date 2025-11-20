import 'dart:convert';
import 'dart:developer' as dev; // <-- ADDED
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // <-- ADDED
import 'package:hmtl/Services/api_services.dart';
import 'package:hmtl/Utils/utils.dart';

class GaugeController extends GetxController {
  // ... (odList, odListMm, gaugeThickness, wallThicknessList remain the same) ...
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
    "6.35",
    "12.70",
    "15.88",
    "19.05",
    "25.40",
    "31.75",
    "38.10",
    "44.45",
    "50.80",
    "57.14",
    "63.50",
    "76.20",
    "82.55",
    "88.90",
    "101.60",
    "107.95",
    "114.30",
    "127.00",
    "133.35",
    "139.70",
    "146.05",
    "152.40",
    "158.75",
    "165.10",
    "171.45",
    "177.80",
    "184.15",
    "190.50",
    "196.85",
    "203.20",
    "209.55",
    "215.90",
    "222.25",
    "228.60",
    "234.95",
    "241.30",
    "247.65",
    "254.00",
    "260.35",
    "266.70",
    "273.05",
    "279.40"
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

  // --- ADDED: Storage and Listener ---
  late final GetStorage _box;
  late final VoidCallback _storageListener;

  // ------------------------------------

  @override
  void onInit() {
    debugPrint('🔹 GaugeController onInit() called');
    setGauge();
    fetchCurrencyCountries();

    // --- ADDED: Storage Init ---
    _box = GetStorage();
    debugPrint('💾 GetStorage initialized');

    _loadPrimaryCurrency();

    _storageListener = _box.listenKey('primaryCurrencyCode', (newCode) {
      debugPrint('📢 Storage listener triggered with value: $newCode');
      if (newCode != null) {
        dev.log('Received storage update! New currency code: $newCode',
            name: 'GaugeController.Listener');
        _loadPrimaryCurrency();
      }
    });
    // ----------------------------

    super.onInit();
  }

  // --- ADDED: Load Primary Currency Method ---
  void _loadPrimaryCurrency() {
    debugPrint('🔸 _loadPrimaryCurrency() called');
    String? savedCode = _box.read('primaryCurrencyCode');
    String? savedName = _box.read('primaryCurrencyName');
    debugPrint('💾 Loaded values => Code: $savedCode | Name: $savedName');

    if (savedCode != null) {
      final nameToUse = savedName ?? savedCode;
      dev.log('Loading primary currency: $savedCode',
          name: 'GaugeController._load');

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
          name: 'GaugeController._load');
      debugPrint('⚠️ No currency found → using INR as default');
      selectedCurrency.value = ['INR', 'Indian Rupee'];
      textEditingControllerExgRate.text = '1.0';
    }
  }

  // ------------------------------------

  // --- ADDED: onClose Method ---
  @override
  void onClose() {
    debugPrint('🔹 GaugeController: onClose called, removing listener');
    dev.log('Disposing storage listener', name: 'GaugeController');
    _storageListener();
    super.onClose();
  }

  // ------------------------------

  RxDouble kgm = 0.0.obs;
  RxDouble ckgm = 0.0.obs;

  RxString selectedOD = ''.obs;
  RxString selectedThickness = ''.obs;
  TextEditingController textEditingControllerOdMm =
      TextEditingController(text: '');
  TextEditingController textEditingControllerThkMm =
      TextEditingController(text: '');
  TextEditingController textEditingControllerRate =
      TextEditingController(text: '');

  // --- MODIFIED: Initialized with default values ---
  TextEditingController textEditingControllerExgRate =
      TextEditingController(text: '1.0');
  TextEditingController textEditingControllerRateKg =
      TextEditingController(text: '0.0');
  TextEditingController textEditingControllerRateLbs =
      TextEditingController(text: '0.0');

  // ------------------------------------------------

  Map globalGaugeMap = {};

  void setGauge() async {
    ByteData data = await rootBundle.load('assets/sheets/gauge.xlsx');
    Uint8List bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      debugPrint('✅ Excel data loaded for $table');
      // Simplified... (your existing parsing logic is fine)
      return;
    }
  }

  // --- MODIFIED: calculateValue ---
  void calculateValue() {
    debugPrint('⚙️ calculateValue() called');
    if (selectedOD.isEmpty) {
      debugPrint('⚠️ No OD selected, aborting.');
      return;
    }
    if (selectedThickness.isEmpty) {
      debugPrint('⚠️ No Thickness selected, aborting.');
      return;
    }

    String thicknessMm;
    if (selectedThickness.contains('SWG')) {
      var thick = Utils.parseToDouble(
          selectedThickness.value.replaceAll('SWG', '').replaceAll(' ', ''));
      thicknessMm =
          wallThicknessList.reversed.elementAt((2 * thick.toInt()) - 1);
    } else {
      var thick = Utils.parseToDouble(
          selectedThickness.value.replaceAll('BWG', '').replaceAll(' ', ''));
      thicknessMm =
          wallThicknessList.reversed.elementAt((2 * thick.toInt()) - 2);
    }

    textEditingControllerOdMm.text = odListMm[odList.indexOf(selectedOD.value)];
    textEditingControllerThkMm.text = thicknessMm;

    kgm.value = (Utils.parseToDouble(textEditingControllerOdMm.text) -
            Utils.parseToDouble(textEditingControllerThkMm.text)) *
        Utils.parseToDouble(textEditingControllerThkMm.text) *
        0.0246615;
    ckgm.value = (Utils.parseToDouble(textEditingControllerOdMm.text) -
            Utils.parseToDouble(textEditingControllerThkMm.text)) *
        Utils.parseToDouble(textEditingControllerThkMm.text) *
        0.0251550;

    debugPrint('📏 Calculated CS kg/m = ${kgm.value}');
    debugPrint('📏 Calculated SS kg/m = ${ckgm.value}');

    isComputed.value = true; // <-- ADDED

    // ADDED: Call getRates to populate fields
    getRates(
        r: textEditingControllerRate.text.isEmpty
            ? '100.0'
            : textEditingControllerRate.text,
        ex: textEditingControllerExgRate.text);
    debugPrint('💹 Called getRates() after calculation');
  }

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

  // --- MODIFIED: resetCalc ---
  void resetCalc() {
    debugPrint('🔄 resetCalc() called');
    selectedOD.value = '';
    selectedThickness.value = '';
    kgm.value = 0.0;
    ckgm.value = 0.0;
    isComputed(false);
    textEditingControllerRate.text = '';
    textEditingControllerExgRate.text = '1.0'; // <-- MODIFIED
    textEditingControllerOdMm.text = '';
    textEditingControllerThkMm.text = '';
    textEditingControllerRateKg.text = '0.0'; // <-- MODIFIED
    textEditingControllerRateLbs.text = '0.0'; // <-- MODIFIED
    selectedCurrency.value = [];
    rate.value = 100.0;
    exgRate.value = 1.0;
    resetList(); // <-- ADDED
    dev.log('Reset tapped. Re-loading primary currency.',
        name: 'GaugeController.resetCalc');
    debugPrint('♻️ Reset done, reloading currency');
    _loadPrimaryCurrency(); // <-- ADDED
  }

  // ------------------------------

  RxDouble rate = 100.0.obs;
  RxDouble exgRate = 1.0.obs;
  RxBool changing = false.obs;

  // --- MODIFIED: getRates (from ManualController) ---
  void getRates({String? r, String? ex}) {
    debugPrint('💱 getRates() called with -> r:$r ex:$ex');

    // computeRate(); // <-- REMOVED circular call

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

    changing.toggle();
    debugPrint('🔁 isChanging toggled -> ${changing.value}');
  }

  // ------------------------------------

  RxBool isComputed = false.obs;

  // REMOVED computeRate() function, its logic is now in calculateValue()

  RxBool loadingCurrency = false.obs;
  RxMap currencyMap = {}.obs;

  // ------------------------------------

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

  // 3. CHANGED: Offline List Loading (Safe)
  void fetchCurrencyCountries() async {
    debugPrint('🌍 fetchCurrencyCountries() started (OFFLINE MODE)');
    try {
      final value =
          await rootBundle.loadString('assets/images/currencies.json');
      if (value.isNotEmpty) {
        debugPrint('✅ Currency JSON loaded successfully from assets');
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];
        suggestedList.clear();
        for (var element in recommends) {
          try {
            var found = (currencyDetails['supported_codes'] as List).firstWhere(
                (e) => e[0] == element.toString(),
                orElse: () => null);
            if (found != null) suggestedList.add(found);
          } catch (e) {}
        }
      }
    } catch (e) {
      debugPrint('❌ Error in fetchCurrencyCountries(): $e');
    }
  }

  // 4. CHANGED: Online V4 Rates (Safe & Free)
  void fetchCurrencyDetails(String country) async {
    debugPrint('🌍 fetchCurrencyDetails() called for $country');
    var primaryCurrency =
        await StorageService.getStorage(key: 'primaryCurrencyCode') ?? 'INR';
    loadingCurrency(true);

    ApiService()
        .getApi(
            // ✅ UPDATED: Use working V4 API
            url: 'https://api.exchangerate-api.com/v4/latest/$country')
        .then((value) async {
      debugPrint('📡 fetchCurrencyDetails() response received');
      if (value != null) {
        var response = jsonDecode(value);

        // ✅ UPDATED: Handle 'rates' key
        if (response['rates'] != null) {
          currencyMap.value = response['rates'];
        } else if (response['conversion_rates'] != null) {
          currencyMap.value = response['conversion_rates'];
        }

        if (currencyMap[primaryCurrency] != null) {
          double newRate =
              double.parse(currencyMap[primaryCurrency].toString());
          textEditingControllerExgRate.text = newRate.toStringAsFixed(2);
          exgRate.value = newRate;
          debugPrint('💹 Updated exgRate = ${exgRate.value}');
          getRates(ex: exgRate.value.toString());
        }
        loadingCurrency(false);
      }
    }).catchError((e) {
      debugPrint('❌ Error fetching rates: $e');
      textEditingControllerExgRate.text = '1.0';
      exgRate.value = 1.0;
      loadingCurrency(false);
    });
  }
}
