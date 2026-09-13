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
import '../screens/vineyard_map_screen.dart';
import '../screens/estate_select_screen.dart';
import '../screens/outcome_screen.dart';

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
    // Estate picker — shown after login/splash, before the Kokotos Estate
    // features. Lays groundwork for multiple farms in the system.
    GoRoute(
      path: '/estates',
      builder: (context, state) => const EstateSelectScreen(),
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
          path: '/outcome',
          builder: (context, state) => const OutcomeScreen(),
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
    // Full-screen vineyard overview map (item 1.a) — outside the shell
    // so it renders without the bottom nav bar, like /profile.
    GoRoute(
      path: '/map',
      builder: (context, state) => const VineyardMapScreen(),
    ),
  ],
);
