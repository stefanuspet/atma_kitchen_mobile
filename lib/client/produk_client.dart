import 'dart:convert';
import 'package:atma_kitchen/entity/produk.dart';
import 'package:http/http.dart';

class ProdukClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/produk';

  static Future<List<Produk>> getProduk() async {
    try {
      print(url + endpoint);
      var response = await get(Uri.http(url, endpoint), headers: {
        "Accept": "application/json",
        "Keep-Alive": "timeout=5, max=1000",
      });
      print(url + endpoint);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = jsonDecode(response.body)['data'];
      return list.map((e) => Produk.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Future.error(e.toString());
    }
  }
}
