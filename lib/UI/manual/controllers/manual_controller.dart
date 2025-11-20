import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 1. Added this for Local JSON
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hmtl/Services/api_services.dart'; // Keeping this for fetchCurrencyDetails
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
  TextEditingController textEditingControllerRateKg =
      TextEditingController(text: '0.0');
  TextEditingController textEditingControllerRateLbs =
      TextEditingController(text: '0.0');
  TextEditingController textEditingControllerExgRate =
      TextEditingController(text: '1.0');

  var odTextList = [];
  var idTextList = [];
  var thkTextList = [];

  RxDouble rate = 100.0.obs;
  RxDouble exgRate = 1.0.obs;

  // RxDouble rateKg = 0.0.obs;
  // RxDouble rateLbs = 0.0.obs;

  // -- CORRECTED VARIABLE TYPE --
  late final GetStorage _box;
  late final VoidCallback _storageListener; // Was StreamSubscription
  // ---------------------------------

  @override
  void onInit() {
    debugPrint('🔹 ManualController: onInit called');
    Future.delayed(Duration(milliseconds: 800), () {
      debugPrint('📌 Requesting focus for OD field');
      focusNodeOd.requestFocus();
    });
    fetchCurrencyCountries();
    super.onInit();
    dev.log('ManualController onInit', name: 'ManualController');

    // Initialize storage
    _box = GetStorage();
    debugPrint('💾 GetStorage initialized');

    // Load the initial currency
    _loadPrimaryCurrency();

    // -- SET UP THE LISTENER --
    _storageListener = _box.listenKey('primaryCurrencyCode', (newCode) {
      debugPrint('📢 Storage listener triggered with value: $newCode');
      if (newCode != null) {
        dev.log('Received storage update! New currency code: $newCode',
            name: 'ManualController.Listener');
        _loadPrimaryCurrency();
      }
    });
  }

  /// This is the logic we previously had in initState.
  /// It's now a reusable method.
  void _loadPrimaryCurrency() {
    debugPrint('🔸 _loadPrimaryCurrency() called');
    String? savedCode = _box.read('primaryCurrencyCode');
    String? savedName = _box.read('primaryCurrencyName');
    debugPrint('💾 Loaded values => Code: $savedCode | Name: $savedName');

    // 🧠 Fix: If code exists but name is null, use code itself
    if (savedCode != null) {
      // Use saved name if available, else fall back to code
      final nameToUse = savedName ?? savedCode;

      dev.log('Loading primary currency: $savedCode',
          name: 'ManualController._load');

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
          name: 'ManualController._load');
      debugPrint('⚠️ No currency found → using INR as default');
      selectedCurrency.value = ['INR', 'Indian Rupee'];
      textEditingControllerExgRate.text = '1.0';
    }
  }

  @override
  void onClose() {
    debugPrint('🔹 ManualController: onClose called, removing listener');
    dev.log('Disposing storage listener', name: 'ManualController');
    _storageListener();
    super.onClose();
  }

  void enterValue(String value) {
    debugPrint('🔹 enterValue() called with: $value');
    print('id $idTextList');
    print('od $odTextList');
    print('thk $thkTextList');

    if (value == 'Enter') {
      debugPrint('⏩ Enter pressed → moving focus');
      if (focusNodeOd.hasFocus) {
        focusNodeOd.nextFocus();
      } else if (focusNodeId.hasFocus) {
        focusNodeId.nextFocus();
      } else if (focusNodeThk.hasFocus) {
        focusNodeThk.nextFocus();
      }
      return;
    }
    if (value == 'C') {
      debugPrint('🧹 Clear pressed → clearing current field');
      if (focusNodeOd.hasFocus) {
        odTextList.clear();
        textEditingControllerOd.clear();
      } else if (focusNodeId.hasFocus) {
        idTextList.clear();
        textEditingControllerId.clear();
      } else if (focusNodeThk.hasFocus) {
        thkTextList.clear();
        textEditingControllerThk.clear();
      }
      return;
    }
    if (value == '<') {
      debugPrint('⌫ Backspace pressed');
      if (focusNodeOd.hasFocus) {
        if (odTextList.isNotEmpty) {
          odTextList.removeLast();
          textEditingControllerOd.text = odTextList.join(' ');
        } else {
          textEditingControllerOd.text = '';
        }
        return;
      } else if (focusNodeId.hasFocus) {
        if (idTextList.isNotEmpty) {
          idTextList.removeLast();
          textEditingControllerId.text = idTextList.join(' ');
        } else {
          textEditingControllerId.text = '';
        }
        return;
      } else if (focusNodeThk.hasFocus) {
        if (thkTextList.isNotEmpty) {
          thkTextList.removeLast();
          textEditingControllerThk.text = thkTextList.join(' ');
          return;
        } else {
          textEditingControllerThk.text = '';
        }
      }
      return;
    }
    debugPrint('🧮 Adding value: $value');
    if (focusNodeOd.hasFocus) {
      debugPrint('➡️ Focus on OD');
      if (textEditingControllerOd.text.isEmpty) {
        odTextList.add(value);
        textEditingControllerOd.text = value;
      } else {
        if (value.contains('/')) {
          odTextList.add(value);
        } else {
          if (odTextList.last.toString().contains('/')) {
            odTextList.add(value);
          } else {
            odTextList.last = '${odTextList.last}$value';
          }
        }
      }

      if (idTextList.isNotEmpty && thkTextList.isEmpty) {
        var thk = (Utils.parseToDouble(odTextList.join(' ')) -
                Utils.parseToDouble(idTextList.join(' '))) /
            2;
        textEditingControllerThk.text = thk.toStringAsFixed(2);
      } else if (thkTextList.isNotEmpty) {
        var id = Utils.parseToDouble(odTextList.join(' ')) -
            Utils.parseToDouble(thkTextList.join(' ')) * 2;
        textEditingControllerId.text = id.toStringAsFixed(2);
      }
      textEditingControllerOd.text = odTextList.join(' ');
      return;
    } else if (focusNodeId.hasFocus) {
      debugPrint('➡️ Focus on ID');
      if (textEditingControllerId.text.isEmpty) {
        idTextList.add(value);
      } else {
        if (value.contains('/')) {
          idTextList.add(value);
        } else {
          if (idTextList.last.toString().contains('/')) {
            idTextList.add(value);
          } else {
            idTextList.last = '${idTextList.last}$value';
          }
        }
      }

      if (thkTextList.isNotEmpty && odTextList.isEmpty) {
        var od = Utils.parseToDouble(idTextList.join(' ')) +
            Utils.parseToDouble(thkTextList.join(' ')) * 2;
        textEditingControllerOd.text = od.toStringAsFixed(2);
      } else if (odTextList.isNotEmpty) {
        var thk = (Utils.parseToDouble(odTextList.join(' ')) -
                Utils.parseToDouble(idTextList.join(' '))) /
            2;
        textEditingControllerThk.text = thk.toStringAsFixed(2);
      }
      textEditingControllerId.text = idTextList.join(' ');
    } else if (focusNodeThk.hasFocus) {
      debugPrint('➡️ Focus on THK');
      if (textEditingControllerThk.text.isEmpty) {
        thkTextList.add(value);
        textEditingControllerThk.text = value;
      } else {
        if (value.contains('/')) {
          thkTextList.add(value);
        } else {
          if (thkTextList.last.toString().contains('/')) {
            thkTextList.add(value);
          } else {
            thkTextList.last = '${thkTextList.last}$value';
          }
        }
      }

      if (odTextList.isEmpty && idTextList.isNotEmpty) {
        var od = Utils.parseToDouble(idTextList.join(' ')) +
            (Utils.parseToDouble(thkTextList.join(' ')) * 2);
        textEditingControllerOd.text = od.toStringAsFixed(2);
      } else if (odTextList.isNotEmpty) {
        var id = Utils.parseToDouble(odTextList.join(' ')) -
            (Utils.parseToDouble(thkTextList.join(' ')) * 2);
        debugPrint('🧮 Calculated ID = $id');
        textEditingControllerId.text = id.toStringAsFixed(2);
      }
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
    debugPrint('⚙️ calculateValue() called');
    isComputed(true);
    kgm.value = (Utils.parseToDouble(textEditingControllerOd.text,
                toMM: selectedUnitIndex.value == 1) -
            Utils.parseToDouble(textEditingControllerThk.text,
                toMM: selectedUnitIndex.value == 1)) *
        Utils.parseToDouble(textEditingControllerThk.text,
            toMM: selectedUnitIndex.value == 1) *
        0.0246615;
    debugPrint('📏 Calculated kg/m = ${kgm.value}');
    print('kg/m  - $kgm');
    print('kg/ft - ${kgm / 3.2808}');
    print('lbs/m - ${kgm * 2.2046226}');
    print('lbs/feet - ${(kgm * 2.2046226) / 3.2808}');
    print(textEditingControllerId.text
        .substring(textEditingControllerId.text.length - 3));

    print('CS---');

    ckgm.value = (Utils.parseToDouble(textEditingControllerOd.text,
                toMM: selectedUnitIndex.value == 1) -
            Utils.parseToDouble(textEditingControllerThk.text,
                toMM: selectedUnitIndex.value == 1)) *
        Utils.parseToDouble(textEditingControllerThk.text,
            toMM: selectedUnitIndex.value == 1) *
        0.0251550;
    debugPrint('📏 Calculated Ckgm = ${ckgm.value}');
    print('kg/m $ckgm');
    print('kg/ft - ${ckgm / 3.2808}');
    print('lbs/m - ${ckgm * 2.2046226}');
    print('lbs/feet - ${(ckgm * 2.2046226) / 3.2808}');

    getRates(r: rate.value.toString());
    debugPrint('💹 Called getRates() after calculation');
    changing.toggle();
  }

  void resetCalc() {
    debugPrint('🔄 resetCalc() called');
    textEditingControllerOd.clear();
    textEditingControllerId.clear();
    textEditingControllerThk.clear();
    textEditingControllerRateKg.text = '0.0';
    textEditingControllerRateLbs.text = '0.0';
    textEditingControllerExgRate.text = '1.0';
    odTextList.clear();
    idTextList.clear();
    thkTextList.clear();
    selectedCurrency.value = ['INR', 'Indian Rupee'];
    exgRate.value = 1;
    isComputed(false);
    resetList();
    rate.value = 100.0;
    dev.log('Reset tapped. Re-loading primary currency.',
        name: 'ManualController.resetCalc');
    debugPrint('♻️ Reset done, reloading currency');
    _loadPrimaryCurrency();
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

  RxBool isFiltered = false.obs;

  void filterCurrencyList(String value) {
    debugPrint('🔹 filterCurrencyList called: $value');
    if (value.isEmpty) {
      debugPrint('🧭 Reset filter list');
      resetList();
      isFiltered(false);
    } else {
      print(currencyDetails['supported_codes']);
      print('---1--');

      // Safe check for null
      if (currencyDetails['supported_codes'] != null) {
        filteredCountryList.value = (currencyDetails['supported_codes'] as List)
            .where((element) =>
                element[0].toLowerCase().contains(value.toLowerCase()) ||
                element[1].toLowerCase().contains(value.toLowerCase()))
            .toList();
        debugPrint('✅ Filtered list updated: ${filteredCountryList.length}');
        isFiltered(true);
      }
    }
  }

  void getRates({String? r, String? ex}) {
    debugPrint('💱 getRates() called with -> r:$r ex:$ex');
    if (r != null && r.isNotEmpty) {
      if (exgRate.value > 0) {
        textEditingControllerRateKg.text =
            (Utils.parseToDouble(r) / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (Utils.parseToDouble(r) / (exgRate.value * 2.205))
                .toStringAsFixed(2);
        rate.value = Utils.parseToDouble(r);
      } else {
        exgRate.value = 1;
        textEditingControllerRateKg.text =
            (Utils.parseToDouble(r) / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (Utils.parseToDouble(r) / (exgRate.value * 2.205))
                .toStringAsFixed(2);
        rate.value = Utils.parseToDouble(r);
      }
      debugPrint(
          '✅ getRates -> RateKg:${textEditingControllerRateKg.text} Lbs:${textEditingControllerRateLbs.text}');
    } else if (ex != null && ex.isNotEmpty) {
      if (Utils.parseToDouble(ex) > 0) {
        textEditingControllerRateKg.text =
            (rate.value / Utils.parseToDouble(ex)).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (rate.value / (Utils.parseToDouble(ex) * 2.205)).toStringAsFixed(2);
        exgRate.value = Utils.parseToDouble(ex);
      } else {
        exgRate.value = 1;
        textEditingControllerRateKg.text =
            (rate.value / exgRate.value).toStringAsFixed(2);
        textEditingControllerRateLbs.text =
            (rate.value / (exgRate.value * 2.205)).toStringAsFixed(2);
      }
      debugPrint('✅ getRates -> ExgRate:${exgRate.value}');
    }
    changing.toggle();
    debugPrint('🔁 Changing toggled -> ${changing.value}');
  }

  void resetList() {
    debugPrint('🔹 resetList() called');
    if (currencyDetails.isNotEmpty &&
        currencyDetails['supported_codes'] != null) {
      filteredCountryList.value = currencyDetails['supported_codes'];
      debugPrint('✅ Filtered list reset (${filteredCountryList.length})');
    }
  }

  // 2. CHANGED: Safe Offline Load from JSON
  void fetchCurrencyCountries() async {
    debugPrint('🌍 fetchCurrencyCountries() started (OFFLINE MODE)');

    try {
      // Load local JSON instead of API call
      final value =
          await rootBundle.loadString('assets/images/currencies.json');

      if (value.isNotEmpty) {
        debugPrint('✅ Currency JSON loaded successfully from assets');
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];

        debugPrint(
            '✅ Supported Codes Count: ${filteredCountryList.length.toString()}');

        // Generate recommended list
        suggestedList.clear();
        for (var element in recommends) {
          try {
            var found = (currencyDetails['supported_codes'] as List).firstWhere(
                (e) => e[0] == element.toString(),
                orElse: () => null);

            if (found != null) {
              suggestedList.add(found);
              debugPrint('⭐ Added to suggestedList: $element');
            }
          } catch (e) {
            debugPrint('⚠️ $element not found in supported_codes');
          }
        }
        debugPrint('✅ Suggested list ready (${suggestedList.length} items)');
      }
    } catch (e) {
      debugPrint('❌ Error in fetchCurrencyCountries(): $e');
    }
  }

  RxBool loadingCurrency = false.obs;
  RxMap currencyMap = {}.obs;
  RxDouble convertAmountToInr = 0.0.obs;

  // 3. UNTOUCHED: Kept exactly as you had it (Original API Logic)
  void fetchCurrencyDetails(String country) async {
    debugPrint('🌍 fetchCurrencyDetails() called for $country');
    loadingCurrency(true);

    ApiService()
        .getApi(
            // ✅ UPDATED URL: Use V4 API (No Key Required)
            url: 'https://api.exchangerate-api.com/v4/latest/$country')
        .then((value) async {
      debugPrint('📡 fetchCurrencyDetails() response received');
      if (value != null) {
        var response = jsonDecode(value);

        if (response['rates'] != null) {
          currencyMap.value = response['rates'];
        } else if (response['conversion_rates'] != null) {
          currencyMap.value = response['conversion_rates'];
        }

        var primaryCurrency =
            await StorageService.getStorage(key: 'primaryCurrencyCode') ??
                'INR';

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
      loadingCurrency(false);
      // Fallback
      textEditingControllerExgRate.text = '1.0';
      exgRate.value = 1.0;
    });
  }
}
