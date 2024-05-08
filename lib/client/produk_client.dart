import 'package:http/http.dart';
class ProdukClient {
  static const String url = '10.0.2.2:8080';
  static const String endpoint = '/api/produk';

  static Future<Response> getProduk() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
