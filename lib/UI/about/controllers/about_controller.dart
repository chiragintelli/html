import 'dart:convert';

import 'package:get/get.dart';
import 'package:hmtl/Services/api_services.dart';

class AboutController extends GetxController {

  @override
  void onInit() {
    fetchCurrencyCountries();
    super.onInit();
  }

  RxList filteredCountryList = [].obs;
  RxMap currencyDetails = {}.obs;
  void fetchCurrencyCountries() {
    // loadingCurrency(true);
    ApiService().getApi(url: 'https://v6.exchangerate-api.com/v6/cb61912390612c8d94615387/codes')
        .then((value) {
      if(value!=null){
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