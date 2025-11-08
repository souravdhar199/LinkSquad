import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../home/presentation/home_screen.dart';
import '../../parties/presentation/parties_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../tournaments/presentation/tournaments_screen.dart';

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
      label: 'Tournaments',
      icon: Icons.emoji_events_outlined,
      initialRoute: '/tournaments',
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (_) => const TournamentsScreen(),
    ),
    _NavItem(
      label: 'Parties',
      icon: Icons.groups_3_outlined,
      initialRoute: '/parties',
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (_) => const PartiesScreen(),
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
