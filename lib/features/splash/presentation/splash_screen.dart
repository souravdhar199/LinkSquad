import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _journeyAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    _pulseAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.easeOutBack),
    );
    _journeyAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 1, curve: Curves.easeInOutCubic),
    );
    _controller.forward();

    _timer = Timer(const Duration(milliseconds: 3400), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.shell);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Transform.scale(
              scale: 0.9 + (_pulseAnimation.value * 0.1),
              child: _AnimatedJourneyOrb(
                progress: _journeyAnimation.value,
                scheme: scheme,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedJourneyOrb extends StatelessWidget {
  const _AnimatedJourneyOrb({
    required this.progress,
    required this.scheme,
  });

  final double progress;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _IconStory(progress: progress),
        const SizedBox(height: 24),
        Opacity(
          opacity: 0.6 + (0.4 * progress),
          child: Text(
            progress < 0.5 ? 'Esports ignition' : 'Outdoor momentum',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}

class _IconStory extends StatelessWidget {
  const _IconStory({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final double esportsOpacity = 1 - (progress.clamp(0, 0.5) / 0.5);
    final double outdoorOpacity = (progress.clamp(0.5, 1) - 0.5) / 0.5;

    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 0.95 + (0.05 * (1 - progress)),
            child: Opacity(
              opacity: esportsOpacity,
              child: _StoryIcon(
                icon: Icons.sports_esports,
                colors: const [Color(0xFF8C8CFF), Color(0xFF5F5FFF)],
              ),
            ),
          ),
          Transform.scale(
            scale: 0.95 + (0.05 * progress),
            child: Opacity(
              opacity: outdoorOpacity,
              child: _StoryIcon(
                icon: Icons.directions_run,
                colors: const [Color(0xFF4ADDB8), Color(0xFF24A77E)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryIcon extends StatelessWidget {
  const _StoryIcon({required this.icon, required this.colors});

  final IconData icon;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 34),
    );
  }
}
