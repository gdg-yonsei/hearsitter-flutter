enum APP_SCREEN { onboarding, category, home, history }

extension AppRouter on APP_SCREEN {
  String get routePath {
    switch (this) {
      case APP_SCREEN.onboarding:
        return '/onboarding';
      case APP_SCREEN.category:
        return '/category';
      case APP_SCREEN.home:
        return '/';
      case APP_SCREEN.history:
        return '/history';
      default:
        return '/';
    }
  }

  String get routeName {
    switch (this) {
      case APP_SCREEN.onboarding:
        return 'onboarding';
      case APP_SCREEN.category:
        return 'category';
      case APP_SCREEN.home:
        return 'home';
      case APP_SCREEN.history:
        return 'history';
      default:
        return 'home';
    }
  }
}
