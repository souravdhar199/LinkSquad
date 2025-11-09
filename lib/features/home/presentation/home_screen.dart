import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<_SportCategory> get _sports => const [
        _SportCategory(
          name: 'Arena Esports',
          icon: Icons.sports_esports,
          accent: Color(0xFF7C84FF),
        ),
        _SportCategory(
          name: 'Outdoor League',
          icon: Icons.directions_run,
          accent: Color(0xFF4CC38A),
        ),
      ];

  List<_Activity> get _activities => const [];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroHeader(scheme: scheme, theme: theme),
                    const SizedBox(height: 24),
                    Text('Sports categories', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 12),
                    _SportCategoryRow(categories: _sports, scheme: scheme),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Text('Recent activity', style: theme.textTheme.titleMedium),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View all'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: _activities.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 120),
                        child: _EmptyActivityState(scheme: scheme),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: index == _activities.length - 1 ? 96 : 16),
                          child: _ActivityCard(activity: _activities[index], scheme: scheme),
                        ),
                        childCount: _activities.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.scheme, required this.theme});

  final ColorScheme scheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.onPrimary.withValues(alpha: 0.1),
                  border: Border.all(color: scheme.onPrimary.withValues(alpha: 0.25)),
                ),
              ),
              CircleAvatar(
                radius: 28,
                backgroundColor: scheme.onPrimary,
                child: Icon(Icons.person, size: 30, color: scheme.primary),
              ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Captain',
                  style: theme.textTheme.titleMedium?.copyWith(color: scheme.onPrimary.withValues(alpha: 0.9)),
                ),
                const SizedBox(height: 10),
                Text(
                  'Curate your next bracket or keep hype alive with the crew.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onPrimary.withValues(alpha: 0.85)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SportCategoryRow extends StatelessWidget {
  const _SportCategoryRow({required this.categories, required this.scheme});

  final List<_SportCategory> categories;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.9, end: 1),
            duration: Duration(milliseconds: 700 + (index * 150)),
            curve: Curves.easeOutBack,
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Container(
              width: 180,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          category.accent.withValues(alpha: 0.9),
                          category.accent.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: category.accent.withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(category.icon, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(category.name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    index == 0 ? 'Competitive brackets' : 'Physical meetups',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: categories.length,
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity, required this.scheme});

  final _Activity activity;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(activity.icon, color: scheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    activity.subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    activity.status,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: scheme.primary, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyActivityState extends StatelessWidget {
  const _EmptyActivityState({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [scheme.primary.withValues(alpha: 0.08), scheme.tertiary.withValues(alpha: 0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.primary.withValues(alpha: 0.12),
            ),
            child: Icon(Icons.hourglass_empty_rounded, size: 42, color: scheme.primary),
          ),
          const SizedBox(height: 22),
          Text('No activity yet', style: theme.textTheme.titleMedium),
          const SizedBox(height: 10),
          Text(
            'Kick off your first tournament or drop an invite to rally the squad.',
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 26),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.auto_fix_high),
            label: const Text('Start something'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SportCategory {
  const _SportCategory({
    required this.name,
    required this.icon,
    required this.accent,
  });

  final String name;
  final IconData icon;
  final Color accent;
}

class _Activity {
  const _Activity({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String status;
  final IconData icon;
}
