import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:atma_kitchen/client/history_client.dart';
import 'package:atma_kitchen/entity/history.dart';
import 'package:atma_kitchen/bottom_nav_customer.dart';

class HistoryPage extends ConsumerWidget {
  HistoryPage({super.key});

  void logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('abilities');
    await pref.remove('token');
    await pref.remove("isLoggedIn");
    context.go('/login'); // Navigate to login after logout
  }

  // Provider to fetch history data
  final listHistoryProvider = FutureProvider<List<History>>((ref) async {
    return await HistoryClient.getHistory();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atma Kitchen'),
        actions: [
          FutureBuilder<bool>(
            future: _checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data!) {
                if (snapshot.data!) {
                  // If user is logged in, show logout button
                  return TextButton(
                    onPressed: () => logout(context),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  // If user is not logged in, show login button
                  return TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              }
              // Default, show an empty container
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final historyAsyncValue = ref.watch(listHistoryProvider);
          return historyAsyncValue.when(
            data: (historyList) {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: 
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 kotak kesamping
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75, // Perbandingan lebar dan tinggi item
                ),
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final history = historyList[index];
                  return HistoryCard(
                    tanggalTransaksi: history.tanggalTransaksi,
                    hargaTotal: history.hargaTotal,
                    metodePembayaran: history.metodePembayaran,
                    statusPesanan: history.statusPesanan,
                    jenisPengiriman: history.jenisPengiriman,
                    tip: history.tip,
                    onTap: () {
                      // Add logic when item is tapped here
                    },
                  );
                },
              );
            },
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text('Error: $error')),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationCustomer(),
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

class HistoryCard extends StatelessWidget {
  final String tanggalTransaksi;
  final int hargaTotal;
  final String metodePembayaran;
  final String statusPesanan;
  final String jenisPengiriman;
  final int? tip; // Mengubah tip menjadi nullable
  final VoidCallback onTap;

  const HistoryCard({
    super.key,
    required this.tanggalTransaksi,
    required this.hargaTotal,
    required this.metodePembayaran,
    required this.statusPesanan,
    required this.jenisPengiriman,
    this.tip, // Mengubah tip menjadi nullable
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tanggalTransaksi,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Harga Total: Rp $hargaTotal',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('Metode Pembayaran: $metodePembayaran',
                      style: const TextStyle(fontSize: 14)),
                  Text('Status Pesanan: $statusPesanan',
                      style: const TextStyle(fontSize: 14)),
                  Text('Jenis Pengiriman: $jenisPengiriman',
                      style: const TextStyle(fontSize: 14)),
                  Text('Tip: Rp ${tip ?? 0}', // Mengubah tip menjadi nullable
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
