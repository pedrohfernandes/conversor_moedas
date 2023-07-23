import 'dart:convert';
import 'dart:async';

import 'package:conversor_moedas/services/api_data.dart';
import 'package:http/http.dart' as http;

const request = "$BASE_URL?key=$API_KEY";

class ApiService {
  Future<Map> getData() async {
    http.Response response = await http.get(Uri.parse(request));
    return jsonDecode(response.body);
  }
}
