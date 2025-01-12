import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/presentation/routes/route_names.dart';
import 'package:recipe/presentation/views/error_view.dart';
import 'package:recipe/presentation/views/home/home_view.dart';
import 'package:recipe/presentation/views/info_view.dart';
import 'package:recipe/presentation/views/main_view.dart';
import 'package:recipe/presentation/views/profile/login_view.dart';
import 'package:recipe/presentation/views/profile/profile_view.dart';
import 'package:recipe/presentation/views/profile/register_view.dart';
import 'package:recipe/presentation/views/recipe/favorite_recipe_view.dart';
import 'package:recipe/presentation/views/settings_view.dart';
import 'package:recipe/presentation/views/splash_view.dart';
import 'package:recipe/presentation/views/start_screen.dart';
import 'package:recipe/presentation/views/support_view.dart';

sealed class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouteName.splash,
    errorBuilder: (context, state) => const ErrorView(),
    routes: [
      GoRoute(
        path: AppRouteName.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRouteName.register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRouteName.start,
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: AppRouteName.errorFound,
        builder: (context, state) => const ErrorView(),
      ),
      GoRoute(
        path: AppRouteName.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRouteName.settings,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: AppRouteName.info,
        builder: (context, state) {
          return const InfoView();
        },
      ),
      GoRoute(
        path: AppRouteName.support,
        builder: (context, state) => const SupportView(),
      ),
      mainView,
    ],
  );

  static final mainView = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainView(navigationShell: navigationShell);
    },
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRouteName.home,
            builder: (context, state) => const HomeView(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRouteName.favorite,
            builder: (context, state) => const FavoriteRecipeView(),
          ),
        ],
      ),
      // StatefulShellBranch(
      //   routes: [
      //     GoRoute(
      //       path: AppRouteName.notification,
      //       builder: (context, state) => const NotificationView(),
      //     ),
      //   ],
      // ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRouteName.profile,
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],
  );
}
