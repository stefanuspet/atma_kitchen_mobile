// ignore_for_file: use_build_context_synchronously

import 'package:atma_kitchen/client/auth_client.dart';
import 'package:atma_kitchen/pages/auth_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void resetPassword() async {
    if (!_fromKey.currentState!.validate()) return;

    try {
      if (_emailController.text.isEmpty) {
        return showSnackBar(context, "Email is required",
            const Color.fromARGB(255, 200, 45, 3));
      }
      Response response = await AuthClient.resetPassword(_emailController.text);
      if (response.statusCode == 200) {
        showSnackBar(context, "Check Your Email", Colors.green);
        await Future.delayed(const Duration(seconds: 1));
        context.go('/');
      } else {
        return showSnackBar(context, '${response.reasonPhrase}', Colors.red);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff1B1B33),
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xffCA9762)),
            onPressed: () {
              context.go('/');
            },
          ),
          backgroundColor: const Color(0xff1B1B33),
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Color(0xffCA9762))),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _fromKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: null), // Add this line (SizedBox
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffCA9762)),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your email address and we will send you a link to reset your password',
                      style: TextStyle(
                          color: Color(0xffCA9762),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: resetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffCA9762),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Reset Password')),
                      ],
                    ),
                  ],
                ),
              ))),
    ));
  }
}
