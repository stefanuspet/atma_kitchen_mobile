import 'package:atma_kitchen/bottom_nav_admin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('abilities');
    pref.remove('token');
    pref.remove("isLoggedIn");
    // ignore: use_build_context_synchronously
    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Home Admin'),
      ),
      body: Center(
        child: Center(
          child: Column(
            children: [
              const Text('Home Admin'),
              ElevatedButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationAdmin(),
    ));
  }
}
