import 'dart:convert';

class Auth {
  String email;
  String password;

  Auth({
    required this.email,
    required this.password,
  });
  factory Auth.fromRawJson(String str) => Auth.fromJson(json.decode(str));
  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        email: json['email'],
        password: json['password'],
      );
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
