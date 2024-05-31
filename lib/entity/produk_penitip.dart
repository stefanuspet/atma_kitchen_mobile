import 'dart:convert';

class ProdukPenitip {
  final int idProduk;
  final String namaProduk;
  final int hargaProduk;
  final int stokProduk;
  final String gambarProduk;
  final String penitip;

  ProdukPenitip({
    required this.idProduk,
    required this.namaProduk,
    required this.hargaProduk,
    required this.stokProduk,
    required this.gambarProduk,
    required this.penitip,
  });

  factory ProdukPenitip.fromRawJson(String str) =>
      ProdukPenitip.fromJson(json.decode(str));
  factory ProdukPenitip.fromJson(Map<String, dynamic> json) => ProdukPenitip(
        idProduk: json['id_produk_penitip'],
        namaProduk: json['nama_produk'],
        hargaProduk: json['harga_produk'],
        stokProduk: json['stok_produk'],
        gambarProduk: 'http://10.0.2.2:8000/storage/produk_penitip/' +
            json['gambar_produk'],
        penitip: json['penitip'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_produk': idProduk,
        'nama_produk': namaProduk,
        'harga_produk': hargaProduk,
        'stok_produk': stokProduk,
        'gambar_produk': gambarProduk,
        'penitip': penitip,
      };
}
