import 'dart:convert';

class Customer {
  int id;
  String namaCustomer;
  String emailCustomer;
  String nohpCustomer;
  String passwordCustomer;
  String rememberToken;

  Customer({
    required this.id,
    required this.namaCustomer,
    required this.emailCustomer,
    required this.nohpCustomer,
    required this.passwordCustomer,
    required this.rememberToken,
  });
  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'],
        namaCustomer: json['namaCustomer'],
        emailCustomer: json['emailCustomer'],
        nohpCustomer: json['nohpCustomer'],
        passwordCustomer: json['passwordCustomer'],
        rememberToken: json['rememberToken'],
      );
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'namaCustomer': namaCustomer,
        'emailCustomer': emailCustomer,
        'nohpCustomer': nohpCustomer,
        'passwordCustomer': passwordCustomer,
        'rememberToken': rememberToken,
      };
}
