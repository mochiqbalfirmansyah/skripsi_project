import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skripsi_project/view/homeView.dart';
import 'package:skripsi_project/view/riwayatPenggunaanView.dart';
import 'package:skripsi_project/view/splashscreenView.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/riwayat',
        builder: (context, state) => RiwayatView(),
      ),
    ],
  );
}
