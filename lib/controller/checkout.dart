import 'dart:convert';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class CheckOutService {
  Future<bool> sentData({required Map data}) async {
    try {
      Uri uri = Uri.parse("https://eplay.coderangon.com/api/order");
      var body = jsonEncode(data);
      var header = {"Accept": "application/json", "Content-Type": "application/json"};
      var res = await http.post(uri, body: body, headers: header);
      log("=======${res.statusCode}========");
      if (res.statusCode == 200) {
        EasyLoading.showSuccess("Order Submitted");
        return true;
      }
    } catch (e) {
      log("Error : $e");
    }
    EasyLoading.showError("Order Failed");
    return false;
  }
}
