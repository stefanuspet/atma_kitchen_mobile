import 'package:flutter/material.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});
  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    // show produk
    return Scaffold(
        appBar: AppBar(
          title: const Text('Produk'),
        ),
        body: const Center(
          child: Text("Produk Page"),
        ));
  }
}
