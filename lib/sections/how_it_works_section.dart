import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HowItWorksSection
//
//  Text-free "How it works" graphics + real, translatable captions on top —
//  nothing is baked into the image.
//   • Wide  : desktop.png  (1×4 strip)  → captions in a Row underneath (these
//             reflow, so they stay aligned on any desktop width).
//   • Narrow: handy1.png    (2×2 grid)  → symbols-only, NO text overlay, so it
//             looks identical on every phone/simulator (badges + icons convey
//             each step). Text-on-raster overlays never line up across devices.
//
//  Desktop captions live in [_stepTitles] (l10n-ready).
// ─────────────────────────────────────────────────────────────────────────────

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  // Native aspect ratios (width / height).
  static const double _desktopAspect = 2172 / 724;
  static const double _mobileAspect = 948 / 1660;

  // Step captions (swap for localized strings later).
  static const List<String> _stepTitles = [
    'Modul einschalten',
    'Mit Bluetooth verbinden',
    'Lieblingssound wählen',
    'Modul ins Polster legen',
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF120B06), // blends with the graphic's dark edges
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 1100 : 460),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 32 : 16,
              vertical: isWide ? 72 : 48,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _SectionLabel('How it works'),
                SizedBox(height: isWide ? 24 : 18),
                isWide ? const _DesktopStrip() : const _MobileGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Desktop: 1×4 strip + captions row below
// ─────────────────────────────────────────────

class _DesktopStrip extends StatelessWidget {
  const _DesktopStrip();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: HowItWorksSection._desktopAspect,
          child: Image.asset('assets/images/desktop.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final t in HowItWorksSection._stepTitles)
              Expanded(child: _StepCaption(text: t, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Mobile: 2×2 grid + captions overlaid per cell
// ─────────────────────────────────────────────

class _MobileGrid extends StatelessWidget {
  const _MobileGrid();

  @override
  Widget build(BuildContext context) {
    // Symbols-only graphic — no text overlay, so it renders identically on
    // every device/simulator (the numbered badges + icons convey each step).
    return AspectRatio(
      aspectRatio: HowItWorksSection._mobileAspect,
      child: Image.asset('assets/images/handy1.png', fit: BoxFit.contain),
    );
  }
}

// ─────────────────────────────────────────────
//  Shared caption + section label
// ─────────────────────────────────────────────

class _StepCaption extends StatelessWidget {
  final String text;
  final double fontSize;
  const _StepCaption({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          height: 1.25,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 13,
        letterSpacing: 4,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
