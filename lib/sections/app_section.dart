import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  AppSection — real screenshots + feature grid
// ─────────────────────────────────────────────

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
    final isWide = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isWide ? 96 : 64,
            ),
            child: isWide
                ? _WideLayout(features: _features)
                : _NarrowLayout(features: _features),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Desktop: phones left │ content right
// ─────────────────────────────────────────────

class _WideLayout extends StatelessWidget {
  final List<_Feature> features;
  const _WideLayout({required this.features});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Phone showcase — fixed intrinsic width
        const _WidePhoneShowcase(),
        const SizedBox(width: 64),
        // Feature content — fills remaining space
        Expanded(child: _AppContent(features: features, centerHeader: false)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Mobile: header → phones → features
// ─────────────────────────────────────────────

class _NarrowLayout extends StatelessWidget {
  final List<_Feature> features;
  const _NarrowLayout({required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppContent(features: features, centerHeader: true, headerOnly: true),
        const SizedBox(height: 40),
        const _NarrowPhoneShowcase(),
        const SizedBox(height: 48),
        _FeatureList(features: features),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Desktop phone showcase: s4 (large) + s2
// ─────────────────────────────────────────────

class _WidePhoneShowcase extends StatelessWidget {
  const _WidePhoneShowcase();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary: s4 — Sound Selection
        _PhoneMockup(
          imagePath: 'assets/images/screens/s4.png',
          phoneWidth: 185,
          glowColor: AppColors.primary,
        ),
        const SizedBox(width: 16),
        // Secondary: s2 — lifestyle/emotional
        _PhoneMockup(
          imagePath: 'assets/images/screens/s2.png',
          phoneWidth: 145,
          glowColor: AppColors.gold,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Mobile phone showcase: s4 centred, s2 below smaller
// ─────────────────────────────────────────────

class _NarrowPhoneShowcase extends StatelessWidget {
  const _NarrowPhoneShowcase();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _PhoneMockup(
            imagePath: 'assets/images/screens/s4.png',
            phoneWidth: 210,
            glowColor: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: _PhoneMockup(
            imagePath: 'assets/images/screens/s2.png',
            phoneWidth: 165,
            glowColor: AppColors.gold,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  iPhone-style phone mockup widget
// ─────────────────────────────────────────────

class _PhoneMockup extends StatefulWidget {
  final String imagePath;
  final double phoneWidth;
  final Color glowColor;

  const _PhoneMockup({
    required this.imagePath,
    required this.phoneWidth,
    required this.glowColor,
  });

  @override
  State<_PhoneMockup> createState() => _PhoneMockupState();
}

class _PhoneMockupState extends State<_PhoneMockup> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final w = widget.phoneWidth;
    final radius = w * 0.18; // proportional corner radius
    final padH = w * 0.05;
    final padTop = w * 0.065;
    final padBottom = w * 0.05;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: w,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFF323232),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.glowColor
                  .withAlpha(_hovered ? 90 : 50),
              blurRadius: _hovered ? 48 : 32,
              spreadRadius: _hovered ? 4 : 0,
            ),
            BoxShadow(
              color: Colors.black.withAlpha(160),
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(padH, padTop, padH, padBottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dynamic island
              Container(
                width: w * 0.28,
                height: (w * 0.034).clamp(5, 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: w * 0.035),
              // Screen
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.085),
                child: AspectRatio(
                  aspectRatio: 9 / 19.5,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: w * 0.04),
              // Home indicator
              Container(
                width: w * 0.32,
                height: (w * 0.022).clamp(3, 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF424242),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  App content: label + headline + feature grid
// ─────────────────────────────────────────────

class _AppContent extends StatelessWidget {
  final List<_Feature> features;
  final bool centerHeader;
  final bool headerOnly;

  const _AppContent({
    required this.features,
    required this.centerHeader,
    this.headerOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final align =
        centerHeader ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerHeader ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        _SectionLabel(label: 'The App'),
        const SizedBox(height: 10),
        Text(
          'Everything you need\nfor a calming session',
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),
        if (!headerOnly) ...[
          const SizedBox(height: 40),
          _FeatureGrid(features: features),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Feature grid (desktop 2×2)
// ─────────────────────────────────────────────

class _FeatureGrid extends StatelessWidget {
  final List<_Feature> features;
  const _FeatureGrid({required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _FeatureCard(feature: features[0])),
            const SizedBox(width: 16),
            Expanded(child: _FeatureCard(feature: features[1])),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _FeatureCard(feature: features[2])),
            const SizedBox(width: 16),
            Expanded(child: _FeatureCard(feature: features[3])),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Feature list (mobile, stacked)
// ─────────────────────────────────────────────

class _FeatureList extends StatelessWidget {
  final List<_Feature> features;
  const _FeatureList({required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features
          .map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _FeatureCard(feature: f),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  Single feature card
// ─────────────────────────────────────────────

class _FeatureCard extends StatelessWidget {
  final _Feature feature;
  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(28),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(feature.icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 14),
          Text(
            feature.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Data model
// ─────────────────────────────────────────────

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
