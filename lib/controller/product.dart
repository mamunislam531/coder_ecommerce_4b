import 'dart:convert';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class GetProductController {
  Future<List> getProduct({required String t}) async {
    try {
      log("=============APIIIIIIIIIIII : ${t}");
      Uri uri;
      if (t == "hot-selling") {
        uri = Uri.parse("https://eplay.coderangon.com/api/products");
      } else if (t == "search") {
        uri = Uri.parse("https://eplay.coderangon.com/api/products/search");
      } else if (t == "latest") {
        uri = Uri.parse("https://eplay.coderangon.com/api/products/latests");
      } else {
        uri = Uri.parse("https://eplay.coderangon.com/api/products/category/$t");
      }
      var res = await http.get(uri);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        return jsonData['data'];
      } else {
        EasyLoading.showError("Product Load Failed.");
      }
    } catch (e) {
      log("==Error : $e");
    }
    return [];
  }
}
