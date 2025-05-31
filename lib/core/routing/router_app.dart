
import 'package:fido_e/features/auth/presentian/login/login_screen.dart';
import 'package:fido_e/features/auth/presentian/regis_or_log_screen.dart';
import 'package:fido_e/features/auth/presentian/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/maps/presentian/map_screen.dart';
import '../../main.dart';

class RouterApp {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String map = '/map';
  static const String regOrLog = '/regorlog';
  static const String login = '/login';
  static const String register = '/register';

  static GoRouter goRoute = GoRouter(
    initialLocation: regOrLog,
    routes: [
      GoRoute(
          path: splash,
          builder: (context, state) {
            return const HomeScreen();
          }),
      GoRoute(
          path: regOrLog,
          builder: (context, state) {
            return const RegisOrLogScreen();
          }),
      GoRoute(
          path: login,
          builder: (context, state) {
            return const LoginScreen();
          }),
      GoRoute(
          path: register,
          builder: (context, state) {
            return const RegisterScreen();
          }),
      GoRoute(
          path: home,
          builder: (context, state) {
            return const SecScreen();
          }),
      GoRoute(
          path: map,
          builder: (context, state) {
            return const MapScreen();
          }),
    ],
    debugLogDiagnostics: true,
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      ),
    ),
  );
}
