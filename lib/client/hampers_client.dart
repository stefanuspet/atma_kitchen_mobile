import 'dart:convert';
import 'package:atma_kitchen/entity/hampers.dart';
import 'package:http/http.dart';

class HampersClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/hampers';

  static Future<List<Hampers>> gethampers() async {
    try {
      print(url + endpoint);
      var response = await get(Uri.http(url, endpoint), headers: {
        "Accept": "application/json",
        "Keep-Alive": "timeout=5, max=1000",
      });
      print(url + endpoint);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = jsonDecode(response.body)['data'];
      return list.map((e) => Hampers.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Future.error(e.toString());
    }
  }
}
