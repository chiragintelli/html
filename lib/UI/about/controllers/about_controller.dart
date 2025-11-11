import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hmtl/Services/api_services.dart';

class AboutController extends GetxController {
  @override
  void onInit() {
    fetchCurrencyCountries();
    super.onInit();
  }

  final linkColor = const Color(0xFF1E88E5); // blue link
  final brochureColor = const Color(0xFF2E7D32); // green download

  RxList filteredCountryList = [].obs;
  RxMap currencyDetails = {}.obs;

  void fetchCurrencyCountries() {
    // loadingCurrency(true);
    ApiService()
        .getApi(
            url:
                'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes')
        .then((value) {
      if (value != null) {
        currencyDetails.value = jsonDecode(value);
        filteredCountryList.value = currencyDetails['supported_codes'];
        // print('object ${countriesList.map((e) => e[1]).toList()}');
        // textEditingControllerExgRate.text = double.parse(currencyDetails[country]['inr'].toString()).toStringAsFixed(2);
        // exgRate.value = double.parse(currencyDetails[country]['inr'].toString());
        // loadingCurrency(false);
        // calculateValue();
      }
    });
  }
}
