import 'package:atma_kitchen/bottom_nav_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeManager extends StatefulWidget {
  const HomeManager({super.key});

  @override
  State<HomeManager> createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
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
          title: const Text('Home Manager'),
        ),
        body: Center(
          child: Center(
            child: Column(
              children: [
                const Text('Home Manager'),
                ElevatedButton(
                  onPressed: logout,
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavigationManager(),
      ),
      // bottom nav
    );
  }
}
