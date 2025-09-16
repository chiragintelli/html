import 'package:get/get.dart';
import 'package:hmtl/UI/chemical/controllers/chemical_controller.dart';
import 'package:hmtl/UI/gauge/controllers/gauge_controller.dart';
import 'package:hmtl/UI/main/controllers/main_controller.dart';
import 'package:hmtl/UI/manual/controllers/manual_controller.dart';
import 'package:hmtl/UI/nps/controllers/nps_controller.dart';

class MainBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => ManualController());
    Get.lazyPut(() => NpsController());
    Get.lazyPut(() => GaugeController());
    Get.lazyPut(() => ChemicalController());
  }

}