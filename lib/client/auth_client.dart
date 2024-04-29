import 'package:atma_kitchen/entity/auth.dart';
import 'package:http/http.dart';

class AuthClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/customers/login';

  static Future<Response> login(Auth auth) async {
    try {
      var response = await post(Uri.http(url, endpoint), headers: {
        "Accept": "application/json"
      }, body: {
        "email_customer": auth.email,
        "password_customer": auth.password
      });
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
