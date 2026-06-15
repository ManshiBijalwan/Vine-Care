import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_shell.dart';
import '../screens/dashboard_screen.dart';
import '../screens/farms_screen.dart';
import '../screens/drone_upload_screen.dart';
import '../screens/phenology_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/block_detail_screen.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/farms',
          builder: (context, state) => const FarmsScreen(),
          routes: [
            GoRoute(
              path: ':blockId',
              builder: (context, state) => BlockDetailScreen(
                blockId: state.pathParameters['blockId'] ?? '',
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/flights',
          builder: (context, state) => const DroneUploadScreen(),
        ),
        GoRoute(
          path: '/phenology',
          builder: (context, state) => const PhenologyScreen(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
