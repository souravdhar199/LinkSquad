import 'package:flutter/material.dart';

class PartiesScreen extends StatelessWidget {
  const PartiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<Map<String, String>> parties = [
      {'title': 'LAN Night', 'subtitle': 'Arcade HQ • Bring your squad'},
      {'title': 'Watch Party', 'subtitle': 'Finals stream • Snacks on us'},
      {'title': 'Creator Meetup', 'subtitle': 'Share highlights & tactics'},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parties',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Social drops and after-match hangs.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: parties.length,
                  itemBuilder: (context, index) {
                    final entry = parties[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        child: ListTile(
                          title: Text(entry['title']!),
                          subtitle: Text(entry['subtitle']!),
                          trailing: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
