import 'dart:convert';

class Produk {
  final int idProduk;
  final String namaProduk;
  final int harga;
  // final int harga_setengah_loyang;
  final int stokProduk;
  final String image;
  final int idUser;

  Produk({
    required this.idProduk,
    required this.namaProduk,
    required this.harga,
    // required this.harga_setengah_loyang,
    required this.stokProduk,
    required this.image,
    required this.idUser,
  });

  factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));
  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        idProduk: json['id_produk'],
        namaProduk: json['nama_produk'],
        harga: json['harga'],
        // harga_setengah_loyang: json['harga_setengah_loyang'],
        stokProduk: json['stok_produk'],
        image: 'http://10.0.2.2:8000/storage/produk/' + json['image'],
        idUser: json['id_user'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_produk': idProduk,
        'nama_produk': namaProduk,
        'harga': harga,
        // 'harga_setengah_loyang': harga_setengah_loyang,
        'stok_produk': stokProduk,
        'image': image,
        'id_user': idUser,
      };
}
