import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class OrderListController {
  Future<List> getData({required String phone}) async {
    try {
      Uri uri = Uri.parse("https://eplay.coderangon.com/api/orders/${phone}");
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      }
    } catch (e) {
      log("Error : $e");
    }
    return [];
  }
}
