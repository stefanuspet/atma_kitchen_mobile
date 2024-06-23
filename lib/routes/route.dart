import 'package:atma_kitchen/onboarding_screen.dart';
import 'package:atma_kitchen/pages/auth_page/reset_password.dart';
import 'package:atma_kitchen/pages/home_page.dart';
import 'package:atma_kitchen/pages/manager_page/home_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/customer_page/home_customer.dart';
import '../pages/admin_page/home_admin.dart';
import '../pages/owner_page/home_owner.dart';
import '../pages/auth_page/login_page.dart';
import '../pages/customer_page/history.dart';

class AppRoute {
  static Future<bool> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seenOnboarding') ?? false;
  }

  static Future<Widget> _handleInitialScreen() async {
    bool seenOnboarding = await _checkOnboardingStatus();
    return seenOnboarding ? HomePage() : const OnboardingScreen();
  }

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => FutureBuilder(
          future: _handleInitialScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return snapshot.data!;
            }
          },
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/resetPassword',
        builder: (context, state) => const ResetPassword(),
      ),
      GoRoute(
        path: '/homeCustomer',
        builder: (context, state) => const HomeCustomer(),
      ),
      GoRoute(
        path: '/homeAdmin',
        builder: (context, state) => const HomeAdmin(),
      ),
      GoRoute(
        path: '/homeManager',
        builder: (context, state) => const HomeManager(),
      ),
      GoRoute(
        path: '/homeOwner',
        builder: (context, state) => const HomeOwner(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => HistoryPage(),
      ),
    ],
  );
}
