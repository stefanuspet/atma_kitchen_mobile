import 'package:atma_kitchen/bottom_nav_customer.dart';
import 'package:atma_kitchen/client/hampers_client.dart';
import 'package:atma_kitchen/client/produk_client.dart';
import 'package:atma_kitchen/client/produk_penitip_client.dart';
import 'package:atma_kitchen/entity/hampers.dart';
import 'package:atma_kitchen/entity/produk.dart';
import 'package:atma_kitchen/entity/produk_penitip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('abilities');
    pref.remove('token');
    pref.remove("isLoggedIn");
  }

  final listProdukProvider = FutureProvider<List<Produk>>((ref) async {
    return await ProdukClient.getProduk();
  });

  final listProdukTitipanProvider =
      FutureProvider<List<ProdukPenitip>>((ref) async {
    return await ProdukPentitipClient.getProdukPenitip();
  });

  final listHampersProvider = FutureProvider<List<Hampers>>((ref) async {
    return await HampersClient.gethampers();
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
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  // Jika pengguna sudah login, tampilkan tombol logout
                  return TextButton(
                    onPressed: () {
                      // Jika sudah login, hapus data login dan arahkan ke halaman login
                      logout();
                      context.go('/login');
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  // Jika pengguna belum login, tampilkan tombol login
                  return TextButton(
                    onPressed: () {
                      // Jika belum login, arahkan pengguna ke halaman login
                      context.go('/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              }
              // Default, tampilkan tombol kosong
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "List Produk",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                final produkListAsyncValue = ref.watch(listProdukProvider);
                return produkListAsyncValue.when(
                  data: (produkList) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 kotak kesamping
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio:
                            0.75, // Perbandingan lebar dan tinggi item
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];
                        return ProductCard(
                          namaProduk: produk.namaProduk,
                          hargaProduk: produk.harga_satu_loyang,
                          stokProduk: produk.stokProduk,
                          image: produk.image,
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
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "List Produk Penitip",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                final produkListAsyncValue =
                    ref.watch(listProdukTitipanProvider);
                return produkListAsyncValue.when(
                  data: (produkList) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 kotak kesamping
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio:
                            0.75, // Perbandingan lebar dan tinggi item
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];
                        return ProductCard(
                          namaProduk: produk.namaProduk,
                          hargaProduk: produk.hargaProduk,
                          stokProduk: produk.stokProduk,
                          image: produk.gambarProduk,
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
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "List Hampers",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                final produkListAsyncValue = ref.watch(listHampersProvider);
                return produkListAsyncValue.when(
                  data: (produkList) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 kotak kesamping
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio:
                            0.75, // Perbandingan lebar dan tinggi item
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];
                        return HampersCard(
                          namaHampers: produk.namaHampers,
                          hargaHampers: produk.hargaHampers,
                          stokHampers: produk.stokHampers,
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
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationCustomer(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String namaProduk;
  final int hargaProduk;
  final int stokProduk;
  final String image;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.namaProduk,
    required this.hargaProduk,
    required this.stokProduk,
    required this.image,
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
            AspectRatio(
              aspectRatio: 16 / 9, // Ubah sesuai dengan rasio gambar
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover, // Atur gambar agar sesuai dengan kotak
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaProduk,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Price: Rp $hargaProduk',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('Stock: $stokProduk',
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

class HampersCard extends StatelessWidget {
  final String namaHampers;
  final int hargaHampers;
  final int stokHampers;
  final VoidCallback onTap;

  const HampersCard({
    super.key,
    required this.namaHampers,
    required this.hargaHampers,
    required this.stokHampers,
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
                    namaHampers,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Price: Rp $hargaHampers',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('Stock: $stokHampers',
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

Future<bool> _checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
