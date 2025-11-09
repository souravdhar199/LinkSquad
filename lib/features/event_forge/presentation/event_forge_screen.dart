import 'package:flutter/material.dart';

class EventForgeScreen extends StatefulWidget {
  const EventForgeScreen({super.key});

  @override
  State<EventForgeScreen> createState() => _EventForgeScreenState();
}

class _EventForgeScreenState extends State<EventForgeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedFormat = 'Bracket';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  double _capacity = 16;
  bool _isOnline = true;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (!mounted || date == null) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (!mounted || time == null) return;
    setState(() {
      _selectedDate = date;
      _selectedTime = time;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event drafted! Hook up backend next.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final String dateLabel = _selectedDate == null || _selectedTime == null
        ? 'Pick start date & time'
        : '${_selectedDate!.month}/${_selectedDate!.day} • ${_selectedTime!.format(context)}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event Forge', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  'Draft tournaments, watch parties, or field days from one canvas.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                _SectionCard(
                  title: 'Essentials',
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Event title',
                          hintText: 'Neon Knights Cup',
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Add a title' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedFormat,
                        decoration: const InputDecoration(labelText: 'Format'),
                        items: const [
                          DropdownMenuItem(value: 'Bracket', child: Text('Bracket tournament')),
                          DropdownMenuItem(value: 'League', child: Text('League / season')),
                          DropdownMenuItem(value: 'Hangout', child: Text('Social hang / watch party')),
                        ],
                        onChanged: (value) => setState(() => _selectedFormat = value ?? _selectedFormat),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Tell players what to expect...',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _SectionCard(
                  title: 'Logistics',
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _isOnline,
                        onChanged: (value) => setState(() => _isOnline = value),
                        contentPadding: EdgeInsets.zero,
                        title: Text(_isOnline ? 'Online session' : 'Physical meet'),
                        subtitle: Text(_isOnline ? 'Share lobby links and platform info' : 'Add venue and amenities'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: _isOnline ? 'Link / server info' : 'Venue',
                          hintText: _isOnline ? 'discord.gg/linksquad' : 'Arcade HQ, Downtown',
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Add details' : null,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _pickDateTime,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Schedule',
                            border: OutlineInputBorder(),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month, color: scheme.primary),
                              const SizedBox(width: 8),
                              Text(dateLabel),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Capacity', style: theme.textTheme.bodyMedium),
                              const Spacer(),
                              Text('${_capacity.round()} players'),
                            ],
                          ),
                          Slider(
                            value: _capacity,
                            min: 4,
                            max: 128,
                            divisions: 31,
                            onChanged: (value) => setState(() => _capacity = value),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _SectionCard(
                  title: 'Tags & extras',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _TagChip(icon: Icons.sports_esports, label: 'Esports'),
                      _TagChip(icon: Icons.music_note, label: 'After party'),
                      _TagChip(icon: Icons.videogame_asset, label: 'Console'),
                      _TagChip(icon: Icons.flight_takeoff, label: 'LAN'),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text('Create draft'),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: scheme.surface,
        border: Border.all(color: scheme.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: scheme.primary.withValues(alpha: 0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: scheme.primary),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.primary)),
        ],
      ),
    );
  }
}
