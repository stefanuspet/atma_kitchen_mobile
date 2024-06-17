import 'dart:convert';

class BahanBaku {
  int id;
  String namaBahanBaku;
  int jumlahTersedia;
  String satuanBahan;
  double hargaSatuan;
  int idUser;
  String? createdAt;
  String? updatedAt;

  BahanBaku({
    required this.id,
    required this.namaBahanBaku,
    required this.jumlahTersedia,
    required this.satuanBahan,
    required this.hargaSatuan,
    required this.idUser,
    this.createdAt,
    this.updatedAt,
  });

  factory BahanBaku.fromRawJson(String str) =>
      BahanBaku.fromJson(json.decode(str));

  factory BahanBaku.fromJson(Map<String, dynamic> json) => BahanBaku(
        id: json['id'] ?? 0,
        namaBahanBaku: json['nama_bahan_baku'] ?? '',
        jumlahTersedia: json['jumlah_tersedia'] ?? 0,
        satuanBahan: json['satuan_bahan'] ?? '',
        hargaSatuan: (json['harga_satuan'] ?? 0).toDouble(),
        idUser: json['id_user'] ?? 0,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_bahan_baku': namaBahanBaku,
        'jumlah_tersedia': jumlahTersedia,
        'satuan_bahan': satuanBahan,
        'harga_satuan': hargaSatuan,
        'id_user': idUser,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
