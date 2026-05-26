import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key});

  static const _features = [
    _Feature(
      icon: Icons.music_note_rounded,
      title: 'Sound Selection',
      description:
          'Choose from a curated library of purring sounds — gentle, deep, or rhythmic. Find the tone that soothes you.',
    ),
    _Feature(
      icon: Icons.timer_rounded,
      title: 'Timer',
      description:
          'Set a sleep timer or a session length. The app fades out gracefully so you drift off without interruption.',
    ),
    _Feature(
      icon: Icons.bookmark_rounded,
      title: 'Saved Programs',
      description:
          'Save your favourite sound and timer combinations as programs. One tap to start your perfect ritual.',
    ),
    _Feature(
      icon: Icons.people_rounded,
      title: 'Client Profiles',
      description:
          'Create individual profiles for different users or sessions — ideal for therapists, families, or personal use.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isWide ? 96 : 64,
            ),
            child: Column(
              children: [
                _SectionLabel(label: 'The App'),
                const SizedBox(height: 12),
                Text(
                  'Everything you need\nfor a calming session',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isWide ? 38 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 56),
                isWide
                    ? _WideFeatureGrid(features: _features)
                    : _NarrowFeatureList(features: _features),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WideFeatureGrid extends StatelessWidget {
  final List<_Feature> features;
  const _WideFeatureGrid({required this.features});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _FeatureCard(feature: features[0]),
              const SizedBox(height: 24),
              _FeatureCard(feature: features[2]),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: [
              _FeatureCard(feature: features[1]),
              const SizedBox(height: 24),
              _FeatureCard(feature: features[3]),
            ],
          ),
        ),
      ],
    );
  }
}

class _NarrowFeatureList extends StatelessWidget {
  final List<_Feature> features;
  const _NarrowFeatureList({required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features
          .map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _FeatureCard(feature: f),
            ),
          )
          .toList(),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final _Feature feature;
  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(feature.icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            feature.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            feature.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 13,
        letterSpacing: 4,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
