import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hmtl/Utils/app_colors.dart';

class Utils {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static double parseToDouble(String input, {bool? toMM, bool? fromMm}) {
    input = input.trim();
    // print('input --- ${input}');
    if (input.contains(' ')) {
      final values = input.split(' ');
      double totalValue;
      if (toMM == true) {
        totalValue = parseToDouble(values[0], toMM: true) +
            parseToDouble(values[1], toMM: true);
      } else {
        totalValue = parseToDouble(values[0]) + parseToDouble(values[1]);
      }
      return totalValue;
    }

    if (input.contains('/')) {
      final parts = input.split('/');
      if (parts.length == 2) {
        final numerator = double.tryParse(parts[0]);
        final denominator = double.tryParse(parts[1]);
        if (numerator != null && denominator != null && denominator != 0) {
          print('n - $numerator d - $denominator mm - $toMM');
          if (toMM == true) {
            return (numerator * 25.4) / denominator;
          } else {
            return numerator / denominator;
          }
        }
      }
      return double.parse(input.replaceAll('/', ''));
      throw FormatException("Invalid fraction format1");
    }

    final value = double.tryParse(input);
    if (value != null) {
      if (toMM == true) {
        return value * 25.4;
      }
      if (fromMm == true) {
        return value / 25.4;
      }
      return value;
    }

    throw FormatException("Invalid number format2 $value");
  }

  static showSnackBar(
      {required String message, EdgeInsets? padding, bool? error}) {
    if (error == true) {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(milliseconds: 2000),
          margin: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
          borderRadius: 14,
          snackPosition: SnackPosition.BOTTOM,
          // title: 'title',
          // message: 'message',
          padding: EdgeInsets.all(3),
          backgroundColor: AppColor.primaryBlueColor,
          messageText: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColor.lightBlueOffColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ),
      );
    }

    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(milliseconds: 2000),
        margin: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
        borderRadius: 14,
        snackPosition: SnackPosition.BOTTOM,
        // title: 'title',
        // message: 'message',
        padding: EdgeInsets.all(3),
        backgroundColor: AppColor.primaryBlueColor,
        messageText: Container(
          // color: AppColor.lightBlueOffColor,
          // padding: EdgeInsets.all(3),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColor.lightBlueOffColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ),
      ),
    );
  }
}

class StorageService {
  static final _runData = GetStorage();

  static setStorage({required String key, required dynamic value}) async {
    await _runData.write(key, value);
  }

  static Future getStorage({required String key}) async {
    return await _runData.read(key);
  }

  static clearData() async {
    await _runData.erase();
  }
}
