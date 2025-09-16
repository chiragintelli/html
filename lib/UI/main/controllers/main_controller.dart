
import 'package:get/get.dart';
import 'package:hmtl/Utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MainController extends GetxController {

  RxInt currentPage = 0.obs;
  final List<String> tabs = ["Manual", "NPS", "About", "Gauge", "Chemical"];

  final Uri _url = Uri.parse('https://www.hmtl.in');


  @override
  void onInit() {
    super.onInit();
    fetchCurrency();
  }

  void fetchCurrency() async {
    var pcc = await StorageService.getStorage(key: 'primaryCurrencyCode');
    if(pcc==null) {
      await StorageService.setStorage(key: 'primaryCurrency', value: 'Indian Rupee');
      await StorageService.setStorage(key: 'primaryCurrencyCode', value: 'INR');
    }

  }

  Future<void> launchWebUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}