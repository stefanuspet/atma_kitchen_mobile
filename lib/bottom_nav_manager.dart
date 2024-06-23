import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationManager extends StatelessWidget {
  const BottomNavigationManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: "laporan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopify_rounded),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_work),
          label: "Alamat",
        )
      ],
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        // Tambahkan kode untuk navigasi ke halaman yang sesuai
        switch (index) {
          case 0:
            // Ketika item Home diklik
            context.go("/homeManager"); // Ganti dengan navigasi ke halaman Home
            break;
          case 1:
            // Ketika item Profile diklik
            context.go("/laporan"); // Ganti dengan navigasi ke halaman Profile
            break;
          case 2:
            // Ketika item History diklik
            context.go("/History"); // Ganti dengan navigasi ke halaman History
            break;
          default:
            break;
        }
      },
    );
  }
}
