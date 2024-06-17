import 'dart:io';

import 'package:atma_kitchen/bottom_nav_manager.dart';
import 'package:atma_kitchen/client/bahan_baku_client.dart';
import 'package:atma_kitchen/entity/bahan_baku.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Laporan extends ConsumerStatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  ConsumerState<Laporan> createState() => _LaporanState();
}

class _LaporanState extends ConsumerState<Laporan> {
  late Future<List<BahanBaku>> futureBahanBaku;

  @override
  void initState() {
    super.initState();
    futureBahanBaku = BahanBakuClient.getBahanBakuMo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printPDF(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BahanBaku>>(
        future: futureBahanBaku,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final bahanBakuList = snapshot.data!;

          return ListView.builder(
            itemCount: bahanBakuList.length,
            itemBuilder: (context, index) {
              final bahanBaku = bahanBakuList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(bahanBaku.namaBahanBaku),
                    subtitle: Text(
                        'Jumlah: ${bahanBaku.jumlahTersedia} ${bahanBaku.satuanBahan}'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Tambahkan logika untuk menangani ketika item diklik
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationManager(),
    );
  }

  Future<void> _printPDF(BuildContext context) async {
    final pdf = pw.Document();
    final bahanBakuList = await futureBahanBaku;
    final currentDate = DateTime.now().toLocal();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Atma Kitchen',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Jl. Centralpark No. 10 Yogyakarta',
                  style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 10),
              pw.Text('LAPORAN Stok Bahan Baku',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                  'Tanggal cetak: ${currentDate.day} ${_getMonthName(currentDate.month)} ${currentDate.year}',
                  style: pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: [
                  'ID',
                  'Nama Bahan Baku',
                  'Jumlah Tersedia',
                  'Satuan Bahan',
                ],
                data: bahanBakuList.map((bahanBaku) {
                  return [
                    bahanBaku.id,
                    bahanBaku.namaBahanBaku,
                    bahanBaku.jumlahTersedia,
                    bahanBaku.satuanBahan,
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/laporan_bahan_baku.pdf');
    await file.writeAsBytes(await pdf.save());

    try {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
    } catch (e) {
      print("Error printing: $e");
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }
}
