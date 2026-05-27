import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  HeroSection
// ─────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight.clamp(620.0, 1020.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background image ─────────────────────────────
          Image.asset('assets/images/schnurrpurr.png', fit: BoxFit.cover),

          // ── Dark gradient overlay ─────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC0D0804),
                  Color(0x881A1008),
                  Color(0xEE1A0E12),
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 56 : 24,
                  vertical: 48,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWide ? 1080 : 540),
                  child: isWide
                      ? _WideLayout()
                      : _NarrowLayout(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Desktop layout: text left | preview right
// ─────────────────────────────────────────────

class _WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── Left: text + buttons ──────────────────────────
        const Expanded(
          flex: 11,
          child: _HeroTextContent(isWide: true),
        ),
        const SizedBox(width: 48),
        // ── Right: product preview ────────────────────────
        Expanded(
          flex: 7,
          child: _ProductPreviewCard(imageHeight: 160),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Mobile layout: stacked
// ─────────────────────────────────────────────

class _NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeroTextContent(isWide: false),
        SizedBox(height: 40),
        _ProductPreviewCard(imageHeight: 120),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Hero text + CTA buttons
// ─────────────────────────────────────────────

class _HeroTextContent extends StatelessWidget {
  final bool isWide;
  const _HeroTextContent({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isWide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        _GlowHeadline(isWide: isWide),
        const SizedBox(height: 22),
        Text(
          'Relax. Purr. Sleep.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 26 : 20,
            color: AppColors.gold,
            letterSpacing: 4,
            fontWeight: FontWeight.w400,
            shadows: const [Shadow(color: Color(0x88000000), blurRadius: 8)],
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'A calming purr experience with sound, vibration and cozy comfort.',
            textAlign: isWide ? TextAlign.left : TextAlign.center,
            style: TextStyle(
              fontSize: isWide ? 17 : 16,
              color: AppColors.textSecondary,
              height: 1.7,
              shadows: const [Shadow(color: Color(0xAA000000), blurRadius: 6)],
            ),
          ),
        ),
        const SizedBox(height: 44),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: [
            _HoverCtaButton(label: 'App Store', icon: Icons.apple, onPressed: () {}),
            _HoverCtaButton(label: 'Google Play', icon: Icons.android, onPressed: () {}),
            const _ComingSoonBadge(),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Glassmorphism product preview card
// ─────────────────────────────────────────────

class _ProductPreviewCard extends StatelessWidget {
  final double imageHeight;
  const _ProductPreviewCard({required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withAlpha(30),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(80),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.gold.withAlpha(45),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Product images row ───────────────────
                Row(
                  children: [
                    Expanded(
                      child: _PreviewImage(
                        assetPath: 'assets/images/pillow.png',
                        height: imageHeight,
                        rotationDeg: -4,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _PreviewImage(
                        assetPath: 'assets/images/purrmodul.png',
                        height: imageHeight,
                        rotationDeg: 4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // ── Thin gold divider ────────────────────
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.gold.withAlpha(100),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ── Label ────────────────────────────────
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.gold, Color(0xFFF5C872)],
                  ).createShader(bounds),
                  child: const Text(
                    'SchnurrPurr Set',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Cozy pillow + calming core module',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary.withAlpha(200),
                    fontSize: 13,
                    height: 1.5,
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

// ─────────────────────────────────────────────
//  Single product image in preview card
// ─────────────────────────────────────────────

class _PreviewImage extends StatefulWidget {
  final String assetPath;
  final double height;
  final double rotationDeg;

  const _PreviewImage({
    required this.assetPath,
    required this.height,
    required this.rotationDeg,
  });

  @override
  State<_PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<_PreviewImage> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        scale: _hovered ? 1.06 : 1.0,
        child: Transform.rotate(
          angle: widget.rotationDeg * 3.14159 / 180,
          child: SizedBox(
            height: widget.height,
            child: Image.asset(
              widget.assetPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Glow headline
// ─────────────────────────────────────────────

class _GlowHeadline extends StatelessWidget {
  final bool isWide;
  const _GlowHeadline({required this.isWide});

  @override
  Widget build(BuildContext context) {
    final fontSize = isWide ? 78.0 : 52.0;
    return Stack(
      alignment: isWide ? Alignment.centerLeft : Alignment.center,
      children: [
        Text(
          'SchnurrPurr',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.gold.withAlpha(55),
            letterSpacing: 2,
            shadows: [
              Shadow(color: AppColors.gold.withAlpha(120), blurRadius: 48),
              Shadow(color: AppColors.primary.withAlpha(80), blurRadius: 80),
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.gold, Color(0xFFF5C872), AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'SchnurrPurr',
            textAlign: isWide ? TextAlign.left : TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  CTA buttons
// ─────────────────────────────────────────────

class _HoverCtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _HoverCtaButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_HoverCtaButton> createState() => _HoverCtaButtonState();
}

class _HoverCtaButtonState extends State<_HoverCtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.primary.withAlpha(120), blurRadius: 20, spreadRadius: 2)]
              : [],
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: 20),
          label: Text(widget.label),
          style: ElevatedButton.styleFrom(
            backgroundColor: _hovered ? AppColors.primary.withAlpha(230) : AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _ComingSoonBadge extends StatefulWidget {
  const _ComingSoonBadge();

  @override
  State<_ComingSoonBadge> createState() => _ComingSoonBadgeState();
}

class _ComingSoonBadgeState extends State<_ComingSoonBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.gold.withAlpha(20) : Colors.transparent,
          border: Border.all(
            color: _hovered ? AppColors.gold : AppColors.gold.withAlpha(128),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Coming soon',
          style: TextStyle(
            color: AppColors.gold,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
