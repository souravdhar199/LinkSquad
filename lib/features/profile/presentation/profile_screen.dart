import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _HeaderBlock(scheme: scheme),
            const SizedBox(height: 24),
            _AboutSection(scheme: scheme),
            const SizedBox(height: 24),
            _SocialLinksSection(scheme: scheme),
            const SizedBox(height: 28),
            _ActivitySection(scheme: scheme),
          ],
        ),
      ),
    );
  }
}

class _HeaderBlock extends StatelessWidget {
  const _HeaderBlock({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: scheme.primary.withValues(alpha: 0.15),
          child: Icon(Icons.person, size: 34, color: scheme.primary),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Player One', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'player.one@example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit_outlined, color: scheme.primary),
        ),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('About me', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_note, color: scheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Tournament architect. Console-first shot caller. '
            'Weekend hikes and outdoor brackets keep the squad balanced.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _SocialLinksSection extends StatelessWidget {
  const _SocialLinksSection({required this.scheme});

  final ColorScheme scheme;

  List<_SocialLink> get _links => const [
        _SocialLink(name: 'Meta', handle: '@linksquad.gg', icon: Icons.facebook),
        _SocialLink(name: 'Instagram', handle: '@linksquad.gg', icon: Icons.camera_alt_outlined),
        _SocialLink(name: 'YouTube', handle: '/c/linksquad', icon: Icons.ondemand_video),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            scheme.primary.withValues(alpha: 0.08),
            scheme.tertiary.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _links
                  .map(
                    (link) => _SocialChip(
                      icon: link.icon,
                      label: link.name,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: scheme.primary),
            tooltip: 'Edit social channels',
          ),
        ],
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: scheme.surface,
          border: Border.all(color: scheme.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: scheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activity hub', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        const _ProfileActivityList(),
      ],
    );
  }
}

class _ProfileActivityList extends StatelessWidget {
  const _ProfileActivityList();

  List<_ActivityListItem> get _items => const [
        _ActivityListItem(
          title: 'Soccer FC 24',
          locationLabel: 'Online lobby',
          locationIcon: Icons.wifi_tethering,
          dateLabel: 'May 12 • 9:00 PM',
          hashtag: '#Esports',
          platformLabel: 'Console',
          platformIcon: Icons.videogame_asset,
          description: 'Crossplay enabled • Group stage kicks off tonight.',
          icon: Icons.sports_soccer,
        ),
        _ActivityListItem(
          title: 'Sunset Spikeball',
          locationLabel: 'Central Park courts',
          locationIcon: Icons.location_on_outlined,
          dateLabel: 'Jun 3 • 5:30 PM',
          hashtag: '#Outdoor',
          platformLabel: 'In-person',
          platformIcon: Icons.sunny,
          description: 'Bring your own gear • Warm ups at 5:30 PM.',
          icon: Icons.sports_volleyball,
        ),
        _ActivityListItem(
          title: 'Valorant Open Ladder',
          locationLabel: 'Remote servers',
          locationIcon: Icons.dns_outlined,
          dateLabel: 'Tonight • 8:15 PM',
          hashtag: '#Esports',
          platformLabel: 'PC lineups',
          platformIcon: Icons.computer,
          description: 'Agent drafts tonight • Spectator slots limited.',
          icon: Icons.sports_esports,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items
          .map(
            (event) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ActivityCard(
                title: event.title,
                locationLabel: event.locationLabel,
                locationIcon: event.locationIcon,
                dateLabel: event.dateLabel,
                hashtag: event.hashtag,
                platformLabel: event.platformLabel,
                platformIcon: event.platformIcon,
                description: event.description,
                icon: event.icon,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.title,
    required this.locationLabel,
    required this.locationIcon,
    required this.dateLabel,
    required this.hashtag,
    required this.platformLabel,
    required this.platformIcon,
    required this.description,
    required this.icon,
  });

  final String title;
  final String locationLabel;
  final IconData locationIcon;
  final String dateLabel;
  final String hashtag;
  final String platformLabel;
  final IconData platformIcon;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 360;

        Widget infoBlock() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _InfoLine(icon: locationIcon, label: locationLabel, fillWidth: true)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoLine(
                      icon: Icons.calendar_today_outlined,
                      label: dateLabel,
                      fillWidth: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _InfoLine(icon: platformIcon, label: platformLabel, fillWidth: true),
              const SizedBox(height: 12),
              _TagRow(hashtag: hashtag),
              const SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodySmall,
              ),
            ],
          );
        }

        Widget buildRow() {
          return Row(
            children: [
              _activityIcon(scheme),
              const SizedBox(width: 16),
              Expanded(child: infoBlock()),
            ],
          );
        }

        Widget buildColumn() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _activityIcon(scheme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(title, style: theme.textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _InfoLine(icon: locationIcon, label: locationLabel, fillWidth: true)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoLine(
                      icon: Icons.calendar_today_outlined,
                      label: dateLabel,
                      fillWidth: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _InfoLine(icon: platformIcon, label: platformLabel, fillWidth: true),
              const SizedBox(height: 12),
              _TagRow(hashtag: hashtag),
              const SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodySmall,
              ),
            ],
          );
        }

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: scheme.surface,
            border: Border.all(color: scheme.primary.withValues(alpha: 0.12)),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: isCompact ? buildColumn() : buildRow(),
        );
      },
    );
  }

  Widget _activityIcon(ColorScheme scheme) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(icon, color: scheme.primary),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.label, this.fillWidth = false});

  final IconData icon;
  final String label;
  final bool fillWidth;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Text text = Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
      overflow: TextOverflow.ellipsis,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: scheme.onSurfaceVariant),
        const SizedBox(width: 6),
        fillWidth ? Expanded(child: text) : text,
      ],
    );
  }
}

class _TagRow extends StatelessWidget {
  const _TagRow({required this.hashtag});

  final String hashtag;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        hashtag,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.primary),
      ),
    );
  }
}

class _ActivityListItem {
  const _ActivityListItem({
    required this.title,
    required this.locationLabel,
    required this.locationIcon,
    required this.dateLabel,
    required this.hashtag,
    required this.platformLabel,
    required this.platformIcon,
    required this.description,
    required this.icon,
  });

  final String title;
  final String locationLabel;
  final IconData locationIcon;
  final String dateLabel;
  final String hashtag;
  final String platformLabel;
  final IconData platformIcon;
  final String description;
  final IconData icon;
}

class _SocialLink {
  const _SocialLink({required this.name, required this.handle, required this.icon});

  final String name;
  final String handle;
  final IconData icon;
}
