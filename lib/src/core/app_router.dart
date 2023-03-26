import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/utils/router_util.dart';
import 'package:hear_sitter/src/core/utils/sharedprefs_util.dart';
import 'package:hear_sitter/src/screens/category/category_screen.dart';
import 'package:hear_sitter/src/screens/history/history_screen.dart';
import 'package:hear_sitter/src/screens/home/home_screen.dart';
import 'package:hear_sitter/src/screens/onboarding/onboarding_screen.dart';

final routerProvider = Provider((ref) => _router);
final prefs = SharedPreferencesUtil().prefs;
bool isOnboard = prefs.getBool('isOnboard') ?? false;

final GoRouter _router = GoRouter(
    initialLocation:
        isOnboard ? APP_SCREEN.home.routePath : APP_SCREEN.onboarding.routePath,
    routes: <GoRoute>[
      GoRoute(
        path: APP_SCREEN.home.routePath,
        builder: (context, state) => const HomseScreen(),
      ),
      GoRoute(
        path: APP_SCREEN.onboarding.routePath,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: APP_SCREEN.category.routePath,
        builder: (context, state) => const CategoryScreen(),
      ),
      GoRoute(
        path: APP_SCREEN.history.routePath,
        builder: (context, state) => const HistoryScreen(),
      )
    ]);
