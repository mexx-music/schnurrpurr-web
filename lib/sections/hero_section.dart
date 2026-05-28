import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────
//  HeroSection
// ─────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final isWide = screenW > 800;
    final isPortrait = screenH >= screenW;
    final heroHeight = screenH.clamp(620.0, 1020.0);

    // Background: the portrait shot (with the tall foreground table) is used
    // only on narrow portrait screens; everything else keeps the landscape one.
    final bgAsset = (!isWide && isPortrait)
        ? 'assets/images/horizont.png'
        : 'assets/images/landingback.png';

    return SizedBox(
      width: double.infinity,
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ────────────────────────────────────
          Image.asset(bgAsset, fit: BoxFit.cover),

          // ── Warm vertical depth overlay ───────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xC40D0804),
                  Color(0x601A1008),
                  Color(0x381A0E12),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // ── Left-side darkening for text legibility ────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xBB0D0804),
                  Color(0x4A0D0804),
                  Colors.transparent,
                ],
                stops: [0.0, 0.52, 1.0],
              ),
            ),
          ),

          // ── Content (centred within the safe area, scrolls if too tall) ──
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  // Centre within the *available* (safe-area) height so the
                  // notch / home-indicator and short iPhone-Safari viewports
                  // never clip the content; it simply scrolls if it can't fit.
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 56 : 24,
                      vertical: isWide ? 40 : 28,
                    ),
                    // MainAxisAlignment.center + the min-height above centre
                    // the block; the leading spacer nudges it down toward the
                    // table on roomy (wide) viewports.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isWide) SizedBox(height: heroHeight * 0.12),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isWide ? 1200 : 560,
                          ),
                          child: isWide ? _WideLayout() : _NarrowLayout(),
                        ),
                      ],
                    ),
                  ),
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
//  Desktop – text left | lifestyle scene right
// ─────────────────────────────────────────────

class _WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 10, child: _HeroTextContent(isWide: true)),
        const SizedBox(width: 32),
        Expanded(
          flex: 9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProductScene(sceneHeight: 400),
              const SizedBox(height: 14),
              _SceneLabel(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Mobile – stacked
// ─────────────────────────────────────────────

class _NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _HeroTextContent(isWide: false),
        const SizedBox(height: 28),
        _ProductScene(sceneHeight: 300, compact: true),
        const SizedBox(height: 12),
        _SceneLabel(),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Lifestyle product scene (no glass card)
// ─────────────────────────────────────────────

class _ProductScene extends StatelessWidget {
  final double sceneHeight;
  // Portrait/mobile: smaller pillow, taller phone, gap kept open.
  final bool compact;
  const _ProductScene({required this.sceneHeight, this.compact = false});

  // Bottom transparent padding of each PNG, as a fraction of the displayed
  // width (measured from the asset alpha bounds). Lets us align the *visible*
  // feet on one ground line instead of the raw image boxes.
  static const double _pillowFoot = 0.111; // pillow.png
  static const double _moduleFoot = 0.35; // purrmodul.png — body base, not the dangling strap

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = sceneHeight;

        // Relative sizes: pillow dominates, module medium, phone smallest.
        // Compact (portrait) shrinks the pillow and grows the phone a touch.
        final pillowW = (w * (compact ? 0.46 : 0.52)).clamp(110.0, 290.0);
        final moduleW = (w * (compact ? 0.40 : 0.38)).clamp(96.0, 205.0);
        final phoneW = (w * (compact ? 0.27 : 0.24)).clamp(72.0, 150.0);

        // Horizontal: pillow left, module centre-front.
        final pillowLeft = -w * 0.02;
        final moduleLeft = w * (compact ? 0.25 : 0.27);
        final moduleVisRight = moduleLeft + moduleW * 0.856; // 599/700

        // Phone placement. Desktop keeps its fixed right margin (unchanged);
        // compact anchors the phone a fixed gap right of the module so the
        // gap can't collapse at narrow widths (clamped min sizes would eat it).
        final phoneRight = w * 0.15;
        final phoneGap = (w * 0.03).clamp(14.0, 60.0);
        final phoneLeft = moduleVisRight + phoneGap;

        // One shared ground line — every product's *visible* bottom lands
        // here, so all three share the same baseline. Lifted enough that the
        // module's dangling strap still rests above the scene floor.
        final baseLine = h * 0.10;
        final pillowBottom = baseLine - pillowW * _pillowFoot;
        final moduleBottom = baseLine - moduleW * _moduleFoot;
        final phoneBottom = baseLine;

        // Visible-centre x of each product (for glow + contact shadows).
        final pillowCx = pillowLeft + pillowW * 0.47;
        final moduleCx = moduleLeft + moduleW * 0.48;
        final phoneCx =
            compact ? phoneLeft + phoneW / 2 : w - phoneRight - phoneW / 2;

        final glowSize = moduleW * 2.2;

        return SizedBox(
          width: w,
          height: h,
          // Clip.none keeps the tilted phone, the glow and the soft
          // shadows from ever being cut off.
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Ambient golden purr-waves around the module ──
              Positioned(
                left: moduleCx - glowSize / 2,
                bottom: baseLine + moduleW * 0.20 - glowSize / 2,
                child: _GlowRings(size: glowSize),
              ),

              // ── Pillow contact shadow (on the shared ground line) ──
              Positioned(
                left: pillowCx - (pillowW * 0.66) / 2,
                bottom: baseLine - 10,
                child: _GroundShadow(width: pillowW * 0.66, height: 24, alpha: 110),
              ),
              // ── Phone contact shadow ──
              Positioned(
                left: phoneCx - (phoneW * 1.05) / 2,
                bottom: baseLine - 8,
                child: _GroundShadow(width: phoneW * 1.05, height: 18, alpha: 105),
              ),

              // ── Pillow — largest element, left ──
              Positioned(
                left: pillowLeft,
                bottom: pillowBottom,
                child: _SceneProduct(
                  assetPath: 'assets/images/pillow.png',
                  width: pillowW,
                  shadowAlpha: 80,
                  shadowBlur: 16,
                  shadowOffset: const Offset(10, 14),
                ),
              ),

              // ── Phone — close to module, slight tilt, never clipped ──
              Positioned(
                left: compact ? phoneLeft : null,
                right: compact ? null : phoneRight,
                bottom: phoneBottom,
                child: Transform.rotate(
                  angle: 0.045, // ≈ 2.5°
                  alignment: Alignment.bottomCenter,
                  child: _PhoneInScene(
                    imagePath: 'assets/images/screens/s2.png',
                    width: phoneW,
                  ),
                ),
              ),

              // ── Module contact shadow (drawn in front of the pillow) ──
              Positioned(
                left: moduleCx - (moduleW * 0.68) / 2,
                bottom: baseLine - 8,
                child: _GroundShadow(width: moduleW * 0.68, height: 22, alpha: 135),
              ),
              // ── Module — centre-front focal point, in front of pillow ──
              Positioned(
                left: moduleLeft,
                bottom: moduleBottom,
                child: _SceneProduct(
                  assetPath: 'assets/images/purrmodul.png',
                  width: moduleW,
                  shadowAlpha: 120,
                  shadowBlur: 12,
                  shadowOffset: const Offset(8, 10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  Soft elliptical ground-contact shadow
// ─────────────────────────────────────────────

class _GroundShadow extends StatelessWidget {
  final double width;
  final double height;
  final int alpha;
  const _GroundShadow({
    required this.width,
    required this.height,
    this.alpha = 110,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(alpha),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Single product in scene with drop shadow
// ─────────────────────────────────────────────

class _SceneProduct extends StatefulWidget {
  final String assetPath;
  final double width;
  final int shadowAlpha;
  final double shadowBlur;
  final Offset shadowOffset;

  const _SceneProduct({
    required this.assetPath,
    required this.width,
    this.shadowAlpha = 95,
    this.shadowBlur = 14,
    this.shadowOffset = const Offset(6, 14),
  });

  @override
  State<_SceneProduct> createState() => _SceneProductState();
}

class _SceneProductState extends State<_SceneProduct> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      widget.assetPath,
      width: widget.width,
      fit: BoxFit.contain,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 230),
        curve: Curves.easeOut,
        alignment: Alignment.bottomCenter,
        scale: _hovered ? 1.04 : 1.0,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Silhouette drop shadow — follows the product outline,
            // so there is no rectangular "card" halo behind the PNG.
            Transform.translate(
              offset: widget.shadowOffset,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: widget.shadowBlur,
                  sigmaY: widget.shadowBlur,
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(widget.shadowAlpha),
                    BlendMode.srcIn,
                  ),
                  child: image,
                ),
              ),
            ),
            image,
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Golden purr-wave glow rings around module
// ─────────────────────────────────────────────

class _GlowRings extends StatelessWidget {
  final double size;
  const _GlowRings({required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Soft warm ambient core — no neon, just a gentle halo.
            Container(
              width: size * 0.62,
              height: size * 0.62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.gold.withAlpha(42),
                    AppColors.gold.withAlpha(14),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
            // Soft concentric purr-waves, fading outward.
            _ring(size * 0.48, 42),
            _ring(size * 0.70, 30),
            _ring(size * 0.88, 20),
            _ring(size * 1.0, 12),
          ],
        ),
      ),
    );
  }

  Widget _ring(double diameter, int alpha) => Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.gold.withAlpha(alpha),
            width: 1.4,
          ),
        ),
      );
}

// ─────────────────────────────────────────────
//  Phone mockup standing in scene
// ─────────────────────────────────────────────

class _PhoneInScene extends StatefulWidget {
  final String imagePath;
  final double width;
  const _PhoneInScene({required this.imagePath, required this.width});

  @override
  State<_PhoneInScene> createState() => _PhoneInSceneState();
}

class _PhoneInSceneState extends State<_PhoneInScene> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final w = widget.width;
    final radius = (w * 0.16).clamp(10.0, 26.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 230),
        curve: Curves.easeOut,
        alignment: Alignment.bottomCenter,
        scale: _hovered ? 1.04 : 1.0,
        child: Container(
          width: w,
          decoration: BoxDecoration(
            color: const Color(0xFF111113),
            borderRadius: BorderRadius.circular(radius),
            // Thin neutral rim — reads as a real device, not a UI card.
            border: Border.all(
              color: Colors.white.withAlpha(22),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(150),
                blurRadius: 34,
                offset: const Offset(6, 20),
              ),
              // Barely-there warm ambient bounce from the module glow.
              BoxShadow(
                color: AppColors.gold.withAlpha(14),
                blurRadius: 26,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.05,
              w * 0.06,
              w * 0.05,
              w * 0.045,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dynamic island
                Container(
                  width: w * 0.28,
                  height: (w * 0.030).clamp(3.0, 7.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: (w * 0.024).clamp(2.0, 5.0)),
                // Screen content
                ClipRRect(
                  borderRadius: BorderRadius.circular(w * 0.08),
                  child: AspectRatio(
                    aspectRatio: 9 / 19.5,
                    child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: (w * 0.034).clamp(2.0, 6.0)),
                // Home indicator bar
                Container(
                  width: w * 0.30,
                  height: (w * 0.022).clamp(2.5, 5.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(3),
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
//  Label below the product scene
// ─────────────────────────────────────────────

class _SceneLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.gold.withAlpha(90),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.gold, Color(0xFFF5C872)],
          ).createShader(bounds),
          child: const Text(
            'SchnurrPurr Set',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'App + cozy pillow + calming core module',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary.withAlpha(190),
            fontSize: 13,
            height: 1.5,
          ),
        ),
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
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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
              shadows: const [
                Shadow(color: Color(0xAA000000), blurRadius: 6),
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: [
            _HoverCtaButton(
              label: 'App Store',
              icon: Icons.apple,
              onPressed: () {},
            ),
            _HoverCtaButton(
              label: 'Google Play',
              icon: Icons.android,
              onPressed: () {},
            ),
            const _ComingSoonBadge(),
          ],
        ),
      ],
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
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(120),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: 20),
          label: Text(widget.label),
          style: ElevatedButton.styleFrom(
            backgroundColor: _hovered
                ? AppColors.primary.withAlpha(230)
                : AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Coming soon badge
// ─────────────────────────────────────────────

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
