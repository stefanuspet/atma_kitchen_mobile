import 'package:atma_kitchen/bottom.nav_owner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({super.key});

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
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
          title: const Text('Home Owner'),
        ),
        body: Center(
          child: Center(
            child: Column(
              children: [
                const Text('Home Owner'),
                ElevatedButton(
                  onPressed: logout,
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavigationOwner(),
      ),
    );
  }
}
