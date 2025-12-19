import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CategoryController {
  Future<List> getCategoryData() async {
    try {
      Uri uri = Uri.parse("https://eplay.coderangon.com/api/categories");
      var res = await http.get(uri);

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['data'];
      }
    } catch (e) {
      log("===Error : $e");
    }
    return [];
  }
}
