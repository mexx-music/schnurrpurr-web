import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  PillowSection  (Schnurr Pillow + Core Module)
// ─────────────────────────────────────────────

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
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isWide ? 96 : 64,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Pillow row ──────────────────────────────────
                isWide
                    ? _PillowRowWide()
                    : const _PillowRowNarrow(),
                const SizedBox(height: 56),
                // ── How it works (module → pillow insertion) ────
                _PillowHowItWorks(isWide: isWide),
                const SizedBox(height: 72),
                // ── Divider ─────────────────────────────────────
                const _GoldDivider(),
                const SizedBox(height: 72),
                // ── Core Module row ─────────────────────────────
                isWide
                    ? _ModuleRowWide()
                    : const _ModuleRowNarrow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Pillow  – wide (image left, content right)
// ─────────────────────────────────────────────

class _PillowRowWide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image — left half
        Expanded(
          child: _ProductImage(
            assetPath: 'assets/images/pillow.png',
            fit: BoxFit.contain,
            height: 420,
          ),
        ),
        const SizedBox(width: 56),
        // Content — right half
        const Expanded(child: _PillowContent()),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Pillow  – narrow (stacked)
// ─────────────────────────────────────────────

class _PillowRowNarrow extends StatelessWidget {
  const _PillowRowNarrow();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ProductImage(
          assetPath: 'assets/images/pillow.png',
          fit: BoxFit.contain,
          height: 300,
        ),
        SizedBox(height: 40),
        _PillowContent(),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Pillow content block
// ─────────────────────────────────────────────

class _PillowContent extends StatelessWidget {
  const _PillowContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(label: 'The Pillow'),
        const SizedBox(height: 12),
        const Text(
          'Schnurr Pillow',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Soft plush pillow designed to hold the SchnurrPurr core module '
          'securely and comfortably.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 17,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        const _FeatureRow(
          icon: Icons.bed_rounded,
          label: 'Cozy plush design',
          description:
              'Soft, washable cover — designed to be held, hugged and used in bed.',
        ),
        const SizedBox(height: 16),
        const _FeatureRow(
          icon: Icons.input_rounded,
          label: 'Hidden module pocket',
          description:
              'Integrated pocket opening for placing the calming core module inside.',
        ),
        const SizedBox(height: 16),
        const _FeatureRow(
          icon: Icons.spa_rounded,
          label: 'Comfort-focused shape',
          description:
              'Soft pillow form designed for relaxation, cuddling and bedtime use.',
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Core Module  – wide (content left, image right)
// ─────────────────────────────────────────────

class _ModuleRowWide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Content — left half
        const Expanded(child: _ModuleContent()),
        const SizedBox(width: 56),
        // Image — right half
        Expanded(
          child: _ProductImage(
            assetPath: 'assets/images/purrmodul.png',
            fit: BoxFit.contain,
            height: 360,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Core Module  – narrow (stacked)
// ─────────────────────────────────────────────

class _ModuleRowNarrow extends StatelessWidget {
  const _ModuleRowNarrow();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ProductImage(
          assetPath: 'assets/images/purrmodul.png',
          fit: BoxFit.contain,
          height: 260,
        ),
        SizedBox(height: 40),
        _ModuleContent(),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Core Module content block
// ─────────────────────────────────────────────

class _ModuleContent extends StatelessWidget {
  const _ModuleContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(label: 'The Module'),
        const SizedBox(height: 12),
        const Text(
          'SchnurrPurr Core Module',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'The heart of the experience. A compact vibration and sound module that can be inserted into the Schnurr Pillow — or used standalone with any cushion you already love.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 17,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        const _FeatureRow(
          icon: Icons.bolt_rounded,
          label: 'Rechargeable battery',
          description: 'USB-C charging, lasts through a full night of use.',
        ),
        const SizedBox(height: 16),
        const _FeatureRow(
          icon: Icons.settings_rounded,
          label: 'Precision tuned motor',
          description:
              'Engineered for 25–150 Hz — the exact range of a real cat purr.',
        ),
        const SizedBox(height: 16),
        const _FeatureRow(
          icon: Icons.devices_rounded,
          label: 'Works with any pillow',
          description:
              'The module slips into a pocket — no hardware modification needed.',
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Shared widgets
// ─────────────────────────────────────────────

class _ProductImage extends StatefulWidget {
  final String assetPath;
  final BoxFit fit;
  final double height;

  const _ProductImage({
    required this.assetPath,
    required this.fit,
    required this.height,
  });

  @override
  State<_ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<_ProductImage> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(_hovered ? 100 : 60),
              blurRadius: _hovered ? 40 : 24,
              spreadRadius: _hovered ? 4 : 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          scale: _hovered ? 1.025 : 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.assetPath,
              fit: widget.fit,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;

  const _FeatureRow({
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.gold.withAlpha(22),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.gold, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GoldDivider extends StatelessWidget {
  const _GoldDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.gold.withAlpha(80),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.pets_rounded,
            color: AppColors.gold.withAlpha(120),
            size: 18,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.gold.withAlpha(80),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
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

// ─────────────────────────────────────────────
//  Pillow "How it works" — 3 photo steps
//  (Shows the core module being inserted into the pillow.)
// ─────────────────────────────────────────────

class _PillowHowItWorks extends StatelessWidget {
  final bool isWide;
  const _PillowHowItWorks({required this.isWide});

  static const List<_PillowStep> _steps = [
    _PillowStep(
      number: 1,
      assetPath: 'assets/images/pillow_open.png',
      title: 'Open pillow pocket',
      text: 'Open the discreet zipper on the back of the pillow.',
    ),
    _PillowStep(
      number: 2,
      assetPath: 'assets/images/pillow_module.png',
      title: 'Insert core module',
      text: 'Place the SchnurrPurr core module inside the pocket.',
    ),
    _PillowStep(
      number: 3,
      assetPath: 'assets/images/pillow.png',
      title: 'Close and relax',
      text:
          'Close the zipper and enjoy comfort, purr sound and calming vibrations.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(label: 'How it works'),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < _steps.length; i++) ...[
                if (i > 0) const SizedBox(width: 16),
                Expanded(child: _PillowStepCard(step: _steps[i])),
              ],
            ],
          )
        else
          Column(
            children: [
              for (var i = 0; i < _steps.length; i++) ...[
                if (i > 0) const SizedBox(height: 14),
                _PillowStepCard(step: _steps[i]),
              ],
            ],
          ),
      ],
    );
  }
}

class _PillowStep {
  final int number;
  final String assetPath;
  final String title;
  final String text;
  const _PillowStep({
    required this.number,
    required this.assetPath,
    required this.title,
    required this.text,
  });
}

class _PillowStepCard extends StatelessWidget {
  final _PillowStep step;
  const _PillowStepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF120B06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numbered badge + step title
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gold.withAlpha(38),
                  border: Border.all(color: AppColors.gold.withAlpha(140)),
                ),
                child: Center(
                  child: Text(
                    '${step.number}',
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  step.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Real product photo, contained on a dark backdrop (blends with both
          // the photos' own dark background and the transparent pillow PNG).
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                color: Colors.black,
                child: Image.asset(step.assetPath, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            step.text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
