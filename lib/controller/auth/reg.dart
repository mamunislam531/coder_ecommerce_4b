import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class RegController {
  Future<bool> createAccountFun({required Map data}) async {
    try {
      Uri uri = Uri.parse("https://b4.coderangon.com/api/register");

      var h = {"Accept": "application/json"};
      var res = await http.post(uri, body: data, headers: h);

      if (res.statusCode == 201) {
        log("======Success");
        return true;
      } else if (res.statusCode == 422) {
        log("=======Email or Phone already taken");
        var e = jsonDecode(res.body);
        log("===${e['message']}");
        return false;
      }
    } catch (nazifa) {
      log("==Error : $nazifa");
    }
    return false;
  }
}
