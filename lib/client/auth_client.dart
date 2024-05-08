import 'package:atma_kitchen/entity/auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/login';

  static Future<Response> login(Auth auth) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Accept": "application/json"},
          body: {"email": auth.email, "password": auth.password});
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> logout(String token) async {
    try {
      var response = await get(
        Uri.http(url, '/api/logout'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> resetPassword(String email) async {
    try {
      var response = await post(Uri.http(url, '/api/customers/requestforget'),
          headers: {"Accept": "application/json"}, body: {"email": email});
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
