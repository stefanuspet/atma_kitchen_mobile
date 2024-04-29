import 'dart:convert';

class Produk {
  int id;
  String namaProduk;
  String hargaProuk;
  String stokProduk;
  String image;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.hargaProuk,
    required this.stokProduk,
    required this.image,
  });
  factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));
  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json['id'],
        namaProduk: json['namaProduk'],
        hargaProuk: json['hargaProuk'],
        stokProduk: json['stokProduk'],
        image: json['image'],
      );
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'namaProduk': namaProduk,
        'hargaProuk': hargaProuk,
        'stokProduk': stokProduk,
        'image': image,
      };
}
