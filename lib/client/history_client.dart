import 'dart:convert';
import 'package:atma_kitchen/entity/history.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/transaksi_cus';

  static Future<List<History>> getHistory() async {
    try {
      // Ambil token dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) throw Exception('Token tidak ditemukan');

      var response = await get(
        Uri.http(url, endpoint),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      Iterable list = jsonDecode(response.body)['data'];
      return list.map((e) => History.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Future.error(e.toString());
    }
  }
}
