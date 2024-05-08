import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationOwner extends StatelessWidget {
  const BottomNavigationOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop),
          label: "History",
        ),
      ],
      onTap: (index) {
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
    );
  }
}
