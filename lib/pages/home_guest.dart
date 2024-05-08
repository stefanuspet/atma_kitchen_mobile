// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeGuest extends StatefulWidget {
  const HomeGuest({super.key});

  @override
  State<HomeGuest> createState() => _HomeGuestState();
}

class _HomeGuestState extends State<HomeGuest> {
  @override
  void initState() {
    super.initState();
    handleLoginRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Home Guest'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text('Home Guest'),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: const Text('Login'),
          ),
        ],
      )),
    ));
  }
}

void handleLoginRoute(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? isLoggedIn = prefs.getBool('isLoggedIn');
  if (isLoggedIn == true) {
    String? abilities = prefs.getString('abilities');
    if (abilities == 'ADMIN') {
      context.go('/homeAdmin');
    } else if (abilities == 'Customer') {
      context.go("/homeCustomer");
    } else if (abilities == 'MO') {
      context.go('/homeManager');
    } else if (abilities == 'OWNER') {
      context.go('/homeOwner');
    }
  } else {
    context.go('/');
  }
}
