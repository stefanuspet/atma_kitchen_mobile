import 'dart:convert';
import 'package:atma_kitchen/entity/bahan_baku.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BahanBakuClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/cetak_laporan_bb_mo';
  static const String endpoint2 = '/api/cetak_laporan_bb_o';

  static Future<List<BahanBaku>> getBahanBakuMo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token is null');
      }

      print(url + endpoint);
      print("this is token: $token");
      var response = await get(Uri.http(url, endpoint), headers: {
        "Accept": "application/json",
        "Keep-Alive": "timeout=5, max=1000",
        "Authorization": "Bearer $token",
      });
      print(url + endpoint);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = jsonDecode(response.body)['data'];
      return list.map((e) => BahanBaku.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Future.error(e.toString());
    }
  }

  static Future<List<BahanBaku>> getBahanBakuOw() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token is null');
      }

      print(url + endpoint);
      print("this is token: $token");
      var response = await get(Uri.http(url, endpoint2), headers: {
        "Accept": "application/json",
        "Keep-Alive": "timeout=5, max=1000",
        "Authorization": "Bearer $token",
      });
      print(url + endpoint);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = jsonDecode(response.body)['data'];
      return list.map((e) => BahanBaku.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Future.error(e.toString());
    }
  }
}
