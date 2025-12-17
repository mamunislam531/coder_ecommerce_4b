import 'dart:convert';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class GetProductController {
  Future<List> getProduct() async {
    try {
      Uri uri = Uri.parse("https://eplay.coderangon.com/api/products");
      // Uri uri = Uri.parse("https://eplay.coderangon.com/api/products/category/2");
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
