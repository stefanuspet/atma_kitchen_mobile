import 'dart:convert';

import 'package:atma_kitchen/entity/auth.dart';
import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/auth_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void login() async {
      if (!_fromKey.currentState!.validate()) return;

      Auth auth = Auth(
        email: _emailController.text,
        password: _passwordController.text,
      );

      try {
        if (auth.email.isEmpty) {
          return showSnackBar(context, "Email is required",
              const Color.fromARGB(255, 200, 45, 3));
        } else if (auth.password.isEmpty) {
          return showSnackBar(context, "Password is required",
              const Color.fromARGB(255, 200, 45, 3));
        }
        Response response = await AuthClient.login(auth);
        if (response.statusCode == 200) {
          String token = jsonDecode(response.body)['token'];
          // ignore: use_build_context_synchronously
          showSnackBar(context, "token : $token", Colors.green);
          await Future.delayed(const Duration(seconds: 1));
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/produkpage');
        } else {
          // ignore: use_build_context_synchronously
          return showSnackBar(context, '${response.reasonPhrase}', Colors.red);
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, e.toString(), Colors.red);
      }
    }

    return Scaffold(
        backgroundColor: const Color(0xff1B1B33),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffCA9762)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter Your Email and Password",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffCA9762)),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: login,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 16), // Atur padding vertikal
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffCA9762), // Atur warna latar belakang
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity,
                              50), // Atur lebar penuh, tinggi 50 piksel
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
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
