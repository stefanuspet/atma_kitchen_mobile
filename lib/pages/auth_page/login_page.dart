// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:atma_kitchen/entity/auth.dart';
import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/auth_client.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    handleLoginRoute(context);
  }

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
          String abilities = jsonDecode(response.body)['abilities'];
          handleTokenAndAbilities(token, abilities);
          setLoggedInStatus(true);
          showSnackBar(context, "Berhasil Login $abilities", Colors.green);
          await Future.delayed(const Duration(seconds: 1));
          handleLoginRoute(context);
        } else {
          return showSnackBar(context, '${response.reasonPhrase}', Colors.red);
        }
      } catch (e) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            },
          ),
          backgroundColor: const Color(0xff1B1B33),
          elevation: 0.0,
        ),
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
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "reset password ? ",
                          style: TextStyle(color: Color(0xffCA9762)),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/resetPassword');
                          },
                          child: const Text(
                            "Click Here",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
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

void handleTokenAndAbilities(String token, String abilities) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('abilities', abilities);
}

void handleLoginRoute(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? isLoggedIn = prefs.getBool('isLoggedIn');
  if (isLoggedIn == true) {
    String? abilities = prefs.getString('abilities');
    if (abilities == 'ADMIN') {
      context.go('/homeAdmin');
    } else if (abilities == 'Customer') {
      context.go("/home");
    } else if (abilities == 'MO') {
      context.go('/homeManager');
    } else if (abilities == 'OWNER') {
      context.go('/homeOwner');
    }
  } else {
    context.go('/login');
  }
}

void setLoggedInStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}
