import 'dart:convert';

class Hampers {
  final int idHampers;
  final String namaHampers;
  final int hargaHampers;
  final int stokHampers;

  Hampers({
    required this.idHampers,
    required this.namaHampers,
    required this.hargaHampers,
    required this.stokHampers,
  });

  factory Hampers.fromRawJson(String str) => Hampers.fromJson(json.decode(str));
  factory Hampers.fromJson(Map<String, dynamic> json) => Hampers(
        idHampers: json['id'],
        namaHampers: json['nama_hampers'],
        hargaHampers: json['harga_hampers'],
        stokHampers: json['stok_hampers'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': idHampers,
        'nama_hampers': namaHampers,
        'harga_hampers': hargaHampers,
        'stok_hampers': stokHampers,
      };
}
