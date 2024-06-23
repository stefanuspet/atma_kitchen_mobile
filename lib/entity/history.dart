import 'dart:convert';

class History {
  final int id;
  final String tanggalTransaksi;
  final String? tanggalAmbil;
  final String? tanggalLunas;
  final String metodePembayaran;
  final String statusPembayaran;
  final String statusPengiriman;
  final String jenisPengiriman;
  final int? tip;
  final int? jarak;
  final int? ongkir;
  final int potonganPoin;
  final int poinPesanan;
  final int hargaSetelahPoin;
  final int? hargaSetelahOngkir;
  final int hargaTotal;
  final int idCustomer;
  final int? idPackaging;
  final String? createdAt;
  final String? updatedAt;

  History({
    required this.id,
    required this.tanggalTransaksi,
    this.tanggalAmbil,
    this.tanggalLunas,
    required this.metodePembayaran,
    required this.statusPembayaran,
    required this.statusPengiriman,
    required this.jenisPengiriman,
    this.tip,
    this.jarak,
    this.ongkir,
    required this.potonganPoin,
    required this.poinPesanan,
    required this.hargaSetelahPoin,
    this.hargaSetelahOngkir,
    required this.hargaTotal,
    required this.idCustomer,
    this.idPackaging,
    this.createdAt,
    this.updatedAt,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json['id'],
        tanggalTransaksi: json['tanggal_transaksi'],
        tanggalAmbil: json['tanggal_ambil'],
        tanggalLunas: json['tanggal_lunas'],
        metodePembayaran: json['metode_pembayaran'],
        statusPembayaran: json['status_pembayaran'],
        statusPengiriman: json['status_pengiriman'],
        jenisPengiriman: json['jenis_pengiriman'],
        tip: json['tip'],
        jarak: json['jarak'],
        ongkir: json['ongkir'],
        potonganPoin: json['potongan_poin'],
        poinPesanan: json['poin_pesanan'],
        hargaSetelahPoin: json['harga_setelah_poin'],
        hargaSetelahOngkir: json['harga_setelah_ongkir'],
        hargaTotal: json['harga_total'],
        idCustomer: json['id_customer'],
        idPackaging: json['id_packaging'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'tanggal_transaksi': tanggalTransaksi,
        'tanggal_ambil': tanggalAmbil,
        'tanggal_lunas': tanggalLunas,
        'metode_pembayaran': metodePembayaran,
        'status_pembayaran': statusPembayaran,
        'status_pengiriman': statusPengiriman,
        'jenis_pengiriman': jenisPengiriman,
        'tip': tip,
        'jarak': jarak,
        'ongkir': ongkir,
        'potongan_poin': potonganPoin,
        'poin_pesanan': poinPesanan,
        'harga_setelah_poin': hargaSetelahPoin,
        'harga_setelah_ongkir': hargaSetelahOngkir,
        'harga_total': hargaTotal,
        'id_customer': idCustomer,
        'id_packaging': idPackaging,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
