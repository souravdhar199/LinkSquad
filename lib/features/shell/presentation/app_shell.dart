import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../event_forge/presentation/event_forge_screen.dart';
import '../../feed/presentation/pulse_feed_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  late final List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      icon: Icons.home_filled,
      initialRoute: AppRoutes.shell,
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (_) => const HomeScreen(),
    ),
    _NavItem(
      label: 'Pulse',
      icon: Icons.dynamic_feed_outlined,
      initialRoute: '/pulse',
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (_) => const PulseFeedScreen(),
    ),
    _NavItem(
      label: 'Forge',
      icon: Icons.edit_calendar_outlined,
      initialRoute: '/forge',
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (_) => const EventForgeScreen(),
    ),
    _NavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      initialRoute: '/profile',
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (_) => const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final NavigatorState? navigator = _items[_currentIndex].navigatorKey.currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        } else {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _items
              .map(
                (item) => Navigator(
                  key: item.navigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute<dynamic>(
                    builder: item.builder,
                    settings: RouteSettings(name: item.initialRoute),
                  ),
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          indicatorColor: scheme.primary.withValues(alpha: 0.12),
          destinations: _items
              .map(
                (item) => NavigationDestination(
                  icon: Icon(item.icon),
                  label: item.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  _NavItem({
    required this.label,
    required this.icon,
    required this.initialRoute,
    required this.navigatorKey,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final String initialRoute;
  final GlobalKey<NavigatorState> navigatorKey;
  final WidgetBuilder builder;
}
