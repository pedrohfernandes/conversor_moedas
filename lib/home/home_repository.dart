import 'dart:convert';
import 'dart:async';

import 'package:conversor_moedas/constants/api_consts.dart';
import 'package:http/http.dart' as http;

const request = "$BASE_URL?key=$API_KEY";

class HomeRepository {
  Future<Map> getData() async {
    http.Response response = await http.get(Uri.parse(request));
    return jsonDecode(response.body);
  }
}
