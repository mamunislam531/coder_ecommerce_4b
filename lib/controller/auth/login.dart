import 'dart:convert';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static Future<bool> login({required String phone, required String pass}) async {
    try {
      Uri uri = Uri.parse("https://b4.coderangon.com/api/login");
      var b = {"phone": phone, "password": pass};
      var h = {"Accept": "application/json"};
      var res = await http.post(uri, body: b, headers: h);

      log("======${phone}  $pass}======");
      log("======${res.body}======");
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body)['token'];
        FlutterSecureStorage storage = FlutterSecureStorage();
        log("=======AA : $data");
        storage.write(key: "token", value: data);
        EasyLoading.showSuccess("Login Success");
        return true;
      } else if (res.statusCode == 422) {
        EasyLoading.showError("Phone or Password Incorrect.");
        return false;
      } else {
        EasyLoading.showError("Something Wrong.");
        return false;
      }
    } catch (e) {
      log("==Error : $e");
    }
    return false;
  }
}
