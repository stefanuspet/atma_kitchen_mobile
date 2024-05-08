import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationManager extends StatelessWidget {
  const BottomNavigationManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(
              icon: Icon(Icons.shopify_rounded), label: "History"),
        ],
        onDestinationSelected: (index) {
          // Tambahkan kode untuk navigasi ke halaman yang sesuai
          switch (index) {
            case 0:
              // Ketika item Home diklik
              context.go("/"); // Ganti dengan navigasi ke halaman Home
              break;
            case 1:
              // Ketika item Profile diklik
              context.go("/"); // Ganti dengan navigasi ke halaman Profile
              break;
            case 2:
              // Ketika item History diklik
              context.go("/"); // Ganti dengan navigasi ke halaman History
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
