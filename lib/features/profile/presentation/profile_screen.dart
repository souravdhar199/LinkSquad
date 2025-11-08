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
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: scheme.primary.withValues(alpha: 0.15),
                  child: Icon(Icons.person, size: 32, color: scheme.primary),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Player One', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('player.one@example.com',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: const [
                  _ProfileTile(title: 'Teams', value: '8 squads'),
                  Divider(height: 1),
                  _ProfileTile(title: 'Tournaments hosted', value: '14 events'),
                  Divider(height: 1),
                  _ProfileTile(title: 'Parties RSVPs', value: '6 upcoming'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Account',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: const [
                  _ProfileTile(title: 'Notifications', value: 'Custom'),
                  Divider(height: 1),
                  _ProfileTile(title: 'Privacy', value: 'Friends only'),
                  Divider(height: 1),
                  _ProfileTile(title: 'Sign out', value: 'Tap to confirm'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text(title),
      trailing: Text(value, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
