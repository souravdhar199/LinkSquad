import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/shell/presentation/app_shell.dart';
import '../features/splash/presentation/splash_screen.dart';
import 'routes.dart';

class LinkSquadApp extends StatelessWidget {
  const LinkSquadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkSquad',
      themeMode: ThemeMode.system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.splash:
            return _buildRoute(const SplashScreen(), settings);
          case AppRoutes.shell:
            return _buildRoute(const AppShell(), settings);
          default:
            return _buildRoute(const SplashScreen(), settings);
        }
      },
      initialRoute: AppRoutes.splash,
    );
  }

  MaterialPageRoute<dynamic> _buildRoute(Widget child, RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => child,
      settings: settings,
    );
  }
}
