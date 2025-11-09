import 'package:flutter/material.dart';

class PulseFeedScreen extends StatelessWidget {
  const PulseFeedScreen({super.key});

  List<_FeedEvent> get _events => const [
        _FeedEvent(
          title: 'Soccer FC 24',
          location: 'Online lobby',
          date: 'May 12 • 9:00 PM',
          tag: '#Esports',
          platform: 'Console • Crossplay',
          description: 'Group stage kick-off stream with co-hosted casters.',
          icon: Icons.sports_soccer,
        ),
        _FeedEvent(
          title: 'Sunset Spikeball',
          location: 'Central Park lawn',
          date: 'Jun 3 • 5:30 PM',
          tag: '#Outdoor',
          platform: 'Physical meet',
          description: 'BYO gear • after-play picnic and highlight reel session.',
          icon: Icons.sports_volleyball,
        ),
        _FeedEvent(
          title: 'Valorant Open Ladder',
          location: 'Remote servers',
          date: 'Tonight • 8:15 PM',
          tag: '#Esports',
          platform: 'PC lineups',
          description: 'Agent drafts wrap at 7pm • Spectator seats limited.',
          icon: Icons.sports_esports,
        ),
        _FeedEvent(
          title: 'Kart Drift Mini Cup',
          location: 'Clubhouse Arcade',
          date: 'Sat • 3:00 PM',
          tag: '#Party',
          platform: 'Switch rigs',
          description: 'Tandem heats + DJ Nova set after finals.',
          icon: Icons.sports_motorsports,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pulse feed', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search games, squads, hosts...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune_rounded),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: _events.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) => _FeedEventCard(event: _events[index], scheme: scheme),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedEventCard extends StatelessWidget {
  const _FeedEventCard({required this.event, required this.scheme});

  final _FeedEvent event;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: scheme.surface,
        border: Border.all(color: scheme.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(event.icon, color: scheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: textTheme.titleMedium),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _InfoChip(icon: Icons.place_outlined, label: event.location)),
                    const SizedBox(width: 8),
                    Expanded(child: _InfoChip(icon: Icons.calendar_today_outlined, label: event.date)),
                  ],
                ),
                const SizedBox(height: 8),
                _InfoChip(icon: Icons.videogame_asset_outlined, label: event.platform),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    event.tag,
                    style: textTheme.labelSmall?.copyWith(color: scheme.primary),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: scheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _FeedEvent {
  const _FeedEvent({
    required this.title,
    required this.location,
    required this.date,
    required this.tag,
    required this.platform,
    required this.description,
    required this.icon,
  });

  final String title;
  final String location;
  final String date;
  final String tag;
  final String platform;
  final String description;
  final IconData icon;
}
