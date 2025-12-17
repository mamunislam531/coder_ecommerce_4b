import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GetProductDetails {
  Future<Map> getData({required int id}) async {
    try {
      Uri uri = Uri.parse("https://eplay.coderangon.com/api/products/$id");
      var res = await http.get(uri);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        return jsonData['data'];
      }
    } catch (e) {
      log("===Log : $e");
    }
    return {};
  }
}
