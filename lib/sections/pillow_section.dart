import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PillowSection extends StatelessWidget {
  const PillowSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, Color(0xFF200F08)],
        ),
      ),
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
                const _SectionLabel(label: 'The Pillow'),
                const SizedBox(height: 12),
                Text(
                  'Feel the purr',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isWide ? 38 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: const Text(
                    'SchnurrPurr goes beyond sound. The Schnurr Pillow pairs a cozy cushion with a gentle vibration module — bringing the full sensory experience of a purring cat right into your hands.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 17,
                      height: 1.7,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: _PillowFeatureCard(
                              icon: Icons.vibration_rounded,
                              title: 'Gentle Vibration',
                              description:
                                  'A carefully tuned motor reproduces the low-frequency rumble of a purr — subtle enough to be felt, not heard over the sound.',
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _PillowFeatureCard(
                              icon: Icons.speaker_rounded,
                              title: 'Integrated Sound',
                              description:
                                  'The pillow works in sync with the app. Your chosen purr plays through your device while vibration mirrors the rhythm.',
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _PillowFeatureCard(
                              icon: Icons.bed_rounded,
                              title: 'Cozy by Design',
                              description:
                                  'Soft, washable cover. Ergonomic shape. Designed to be held, hugged, or placed under your head while you unwind.',
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: const [
                          _PillowFeatureCard(
                            icon: Icons.vibration_rounded,
                            title: 'Gentle Vibration',
                            description:
                                'A carefully tuned motor reproduces the low-frequency rumble of a purr — subtle enough to be felt, not heard over the sound.',
                          ),
                          SizedBox(height: 20),
                          _PillowFeatureCard(
                            icon: Icons.speaker_rounded,
                            title: 'Integrated Sound',
                            description:
                                'The pillow works in sync with the app. Your chosen purr plays through your device while vibration mirrors the rhythm.',
                          ),
                          SizedBox(height: 20),
                          _PillowFeatureCard(
                            icon: Icons.bed_rounded,
                            title: 'Cozy by Design',
                            description:
                                'Soft, washable cover. Ergonomic shape. Designed to be held, hugged, or placed under your head while you unwind.',
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PillowFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _PillowFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.gold, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
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
