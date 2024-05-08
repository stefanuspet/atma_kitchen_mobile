// ignore_for_file: use_build_context_synchronously
import 'package:atma_kitchen/bottom_nav_customer.dart';
import 'package:atma_kitchen/client/auth_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key});

  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');
    Response response = await AuthClient.logout(token!);
    if (response.statusCode != 200) {
      return showSnackBar(context, '${response.reasonPhrase}', Colors.red);
    }
    await Future.delayed(const Duration(seconds: 1));

    pref.remove('abilities');
    pref.remove('token');
    pref.remove("isLoggedIn");
    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Home Customer'),
      ),
      body: Center(
        child: Center(
          child: Column(
            children: [
              const Text('Home Customer'),
              ElevatedButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationCustomer(),
    ));
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  // ignore: non_constant_identifier_names
  final Scaffold = ScaffoldMessenger.of(context);
  Scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: Scaffold.hideCurrentSnackBar),
    ),
  );
}
