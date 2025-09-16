import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
// import 'package:talentwale/Services/app_routes.dart';
// import 'package:talentwale/Utils/app_strings.dart';
// import 'package:talentwale/Utils/utils.dart';

enum RequestType {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

class ApiService {
  // Future<Map<String, String>> tknHeader({bool? multi}) async {
  //   print("##################### ${await StorageService.getStorage(key: CommonKey.AUTH_TOKEN)}");
  //   // return {
  //   //   // 'Content-Disposition': 'multipart/form-data',
  //   //   'Content-Type': 'application/json',
  //   //   // 'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
  //   // };
  //   return multi==true? {
  //     // 'Content-Disposition': 'multipart/form-data',
  //     'Content-Type': 'multipart/form-data',
  //
  //     // 'Content-Type': 'application/json',
  //     // 'Accept': 'application/json',
  //     'Authorization': 'Bearer ${await StorageService.getStorage(key: CommonKey.AUTH_TOKEN) ?? ''}'
  //   }:{
  //     // 'Content-Disposition': 'multipart/form-data',
  //     // 'Content-Type': 'multipart/form-data',
  //     'Content-Type': 'application/json',
  //     // 'Accept': 'application/json',
  //     'Authorization': 'Bearer ${await StorageService.getStorage(key: CommonKey.AUTH_TOKEN) ?? ''}'
  //   };
  // }

  Future<String?> deleteApi({
    required String url,

  }) async {
    try {
      // print("URL ~~~~~~~~~~~~~~~~> $url\nRequest Body ~~~~~~~> $queryParameters");

      // var request = http.MultipartRequest('DELETE', Uri.parse(url));
      // request.fields.addAll(queryParameters ?? {});
      // print('key ${multipartKey != null && multipartList != null && multipartList.isNotEmpty} --- ${multipartList!.length}');
      // if (multipartKey != null && multipartList != null && multipartList.isNotEmpty) {
      //   for (int index = 0; index < multipartList.length; index++) {
      //     print("Multipart key ~~~> $multipartKey\nMultipart list ~~~> $multipartList");
      //     request.files.add(await http.MultipartFile.fromPath(multipartKey, multipartList[index]));
      //   }
      // }
      //
      // if (multipartKey2 != null && multipartList2 != null && multipartList2.isNotEmpty) {
      //   for (int index = 0; index < multipartList2.length; index++) {
      //     request.files.add(await http.MultipartFile.fromPath('$multipartKey2[$index]', multipartList2[index]));
      //     print("Multipart key ~~~> $multipartKey2\nMultipart list ~~~> $multipartList2");
      //   }
      // }

      // multipartKey!=null?
      // request.headers.addAll(await tknHeader(multi: true)):
      // request.headers.addAll(await tknHeader());

      http.Response? response;

      // ///REQUEST CODE
      // if(multipartKey!=null) {
      //   response = await http.Response.fromStream(await request.send());
      // }

      ///DELETE CODE
      response = await http.delete(
        // headers: await tknHeader(),
        Uri.parse(url),
      );

      print('🔴️🔴️🔴️🔴️🔴 DELETE');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("✅✅✅✅✅✅✅✅✅✅ SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");
        print(response.body);
        print("✅✅✅✅✅✅✅✅✅✅ SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");

        return response.body;
      } else {
        print("❌❌❌❌❌❌❌❌❌❌ FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");
        print(response.body);
        print("❌❌❌❌❌❌❌❌❌❌ FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");

        return null;
      }
    } catch (e) {
      print("🛑🛑🛑🛑🛑🛑🛑🛑 ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");
      print('API FAILED TO CALL $url');
      print("🛑🛑🛑🛑🛑🛑🛑🛑 ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");

      return null;
    }
  }

  Future<String?> patchApi({
    required String url,

  }) async {
    try {

      http.Response? response;

      ///PATCH CODE
      response = await http.patch(
        // headers: await tknHeader(),
        Uri.parse(url),
      );

      print('🩹🩹🩹🩹🩹 PATCH');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("✅✅✅✅✅✅✅✅✅✅ SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");
        print(response.body);
        print("✅✅✅✅✅✅✅✅✅✅ SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");

        return response.body;
      } else {
        print("❌❌❌❌❌❌❌❌❌❌ FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");
        print(response.body);
        print("❌❌❌❌❌❌❌❌❌❌ FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");

        return null;
      }
    } catch (e) {
      print("🛑🛑🛑🛑🛑🛑🛑🛑 ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");
      print('API FAILED TO CALL $url');
      print("🛑🛑🛑🛑🛑🛑🛑🛑 ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");

      return null;
    }
  }

  Future<String?> getApi({
    required String url,
    Map<String, String>? queryParameters,
    bool? forLogin
  }) async {

    // if(forLogin!=true){
    //   if(!(await checkAuthToken())) {
    //     if(getx.Get.currentRoute!=AppRoutes.login) {
    //       StorageService.clearData();
    //       StorageService.setStorage(key: CommonKey.ON_BOARDED, value: true);
    //       getx.Get.offAllNamed(AppRoutes.login);
    //     }
    //     return '';
    //   }
    // }

    try {
      print("URL ~~~~~~~~~~~~~~~~> $url\nRequest Body ~~~~~~~> $queryParameters");
      var request = http.MultipartRequest('GET', Uri.parse(url));
      //
      request.fields.addAll(queryParameters ?? {});
      // request.headers.addAll(await tknHeader());

      // http.Response response = await http.get(Uri.parse(url));
      http.Response response = await http.Response.fromStream(await request.send());
      print('🟦🟦🟦🟦🟦 GET');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("✅✅✅✅✅✅✅✅✅✅ SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");
        print(response.body);
        print("✅✅✅✅✅✅✅✅✅✅ SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");

        return response.body;
      } else {
        print("❌❌❌❌❌❌❌❌❌❌ FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");
        print(response.body);
        print("❌❌❌❌❌❌❌❌❌❌ FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");

        return null;
      }
    } catch (e) {
      print("🛑🛑🛑🛑🛑🛑🛑🛑 ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");
      print('API FAILED TO CALL $url');
      print("🛑🛑🛑🛑🛑🛑🛑🛑 ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");

      return null;
    }
  }

  final dio = Dio();

  Future dioPost({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? formData,
    bool? multi,
  }) async {
    try {
      print("URL ~~~~~~~~~~~~~~~~> $url\nDIO Request Body ~~~~~~~> ${formData ?? queryParameters}");

      // if(forLogin!=true){
      //   if(!(await checkAuthToken())) {
      //not one thing is right in my life right now. everything seems to attack me to my core. i feel like my core is revealed and even a simple touch can give it damage. even open mouth to speak seems hard. its never been like this. its impossible to get out of this phase, dont know where to start
      //     if(getx.Get.currentRoute!=AppRoutes.login) {
      //       StorageService.clearData();
      //       StorageService.setStorage(key: CommonKey.ON_BOARDED, value: true);
      //       getx.Get.offAllNamed(AppRoutes.login);
      //     }
      //     return '';
      //   }
      // }

      Response response;
      // response = await dio.request(
      //   url,
      //   // queryParameters: queryParameters,
      //   data: queryParameters,
      //   options: Options(
      //     headers: await tknHeader(),
      //     method: 'post',
      //     contentType: 'application/json',
      //   ),
      // );
      response = await dio.post(
        url,
        queryParameters: queryParameters,
        data: formData!=null? (multi==true? FormData.fromMap(formData) : formData) : null,
        options: Options(
          // headers: await tknHeader(multi: multi==true?true:null),
          validateStatus: (status) {
            return status! < 500 || status == 500;
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print("✅✅✅✅✅✅✅✅✅✅ DIO SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");
        print(response.data);
        print("✅✅✅✅✅✅✅✅✅✅ DIO SUCCESS API $url ${response.statusCode} ✅✅✅✅✅✅✅✅✅✅");

        return response.data;
      } else {
        print("❌❌❌❌❌❌❌❌❌❌ DIO FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");
        print(response.data);
        print("❌❌❌❌❌❌❌❌❌❌ DIO FAIL API $url ${response.statusCode} ❌❌❌❌❌❌❌❌❌❌");

        return null;
      }
    } catch (e) {
      print("🛑🛑🛑🛑🛑🛑🛑🛑 DIO ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");
      print('API FAILED TO CALL $url');
      print('$e');
      print("🛑🛑🛑🛑🛑🛑🛑🛑 DIO ERROR API 🛑🛑🛑🛑🛑🛑🛑🛑");

      return null;
    }
  }

  // Future<bool> checkAuthToken() async {
  //
  //   var response = await http.post(
  //     // headers: await tknHeader(),
  //     Uri.parse(Urls.checkauthtoken),
  //     // body: jsonEncode(queryParameters),
  //   );
  //
  //   print("🔒🔒🔒🔒🔒🔒🔒🔒🔒🔒 AUTH API ${response.statusCode} 🔒🔒🔒🔒🔒🔒🔒🔒🔒🔒");
  //
  //   if(response.statusCode==200){
  //     return true;
  //   }
  //   return false;
  // }
}

ApiService apiService = ApiService();
