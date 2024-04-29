import 'package:atma_kitchen/pages/login_page.dart';
import 'package:atma_kitchen/pages/produk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
        routes: {
          '/produkpage': (context) => const ProdukPage(),
          '/loginpage': (context) => const LoginPage()
        });
  }
}
