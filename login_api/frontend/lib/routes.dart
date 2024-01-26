import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_api/pages/contas.page.dart';
import 'package:login_api/pages/extrato/extrato.page.dart';
import 'package:login_api/pages/home/home.page.dart';
import 'package:login_api/pages/home/home.page_tab.dart';
import 'package:login_api/pages/profile/profile.page.dart';
import 'package:login_api/pages/register/register.page.dart';
import 'package:login_api/pages/statements/statements.page.dart';

import 'pages/bottom.dart';
import 'pages/login/landing.page.dart';
import 'pages/login/login.page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey2 = GlobalKey<NavigatorState>();

final routes = GoRouter(
  initialLocation: '/',
  //navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(
        child: LoginPage(),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
      // pageBuilder: (context, state) => MaterialPage(
      //   child: RegisterPage(),
      //   fullscreenDialog: true,
      // ),
    ),
    GoRoute(
      path: '/contas',
      builder: (context, state) => ContasPage(),
      // pageBuilder: (context, state) => const MaterialPage(
      //   child: ContasPage(),
      //   fullscreenDialog: true,
      // ),
    ),
    GoRoute(
      path: '/profile',
      // parentNavigatorKey: _shellNavigatorKey2,
      // pageBuilder: (context, state) => const MaterialPage(
      //   child: ProfilePage(),
      //   fullscreenDialog: true,
      // ),
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/accounts',
      //builder: (context, state) => HomePageTab(),
      builder: (context, state) => BottomNavBar(body: HomePageTab()),
    ),

    GoRoute(
      path: '/transfers',
      //builder: (context, state) => ExtratoPage(),
      builder: (context, state) => BottomNavBar(body: ExtratoPage()),
    ),
    GoRoute(
      path: '/statements',
      builder: (context, state) => BottomNavBar(body: StatementsTab()),
      // pageBuilder: (context, state) => const MaterialPage(
      //   child: ContasPage(),
      //   fullscreenDialog: true,
      // ),
    ),
    // ShellRoute(
    //   navigatorKey: _shellNavigatorKey,
    //   builder: (context, state, child) {
    //     return BottomNavBar(body: child);
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/home',
    //       builder: (context, state) => HomePageTab(),
    //     ),
    //     GoRoute(
    //       path: '/transfers',
    //       builder: (context, state) => ExtratoPage(),
    //     ),
    //   ],
    // ),
  ],
);
