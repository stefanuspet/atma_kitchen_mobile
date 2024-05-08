import 'package:atma_kitchen/pages/auth_page/reset_password.dart';
import 'package:atma_kitchen/pages/home_guest.dart';
import 'package:atma_kitchen/pages/manager_page/home_manager.dart';
import 'package:go_router/go_router.dart';
import '../pages/customer_page/home_customer.dart';
import '../pages/admin_page/home_admin.dart';
import '../pages/owner_page/home_owner.dart';
import '../pages/auth_page/login_page.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeGuest(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
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
]);
