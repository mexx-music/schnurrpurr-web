import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight.clamp(600.0, 1000.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/schnurrpurr.png', fit: BoxFit.cover),
          // Dark gradient overlay for readability
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC0D0804),
                  Color(0x991A1008),
                  Color(0xE61A0E12),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 48 : 24,
                  vertical: 48,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Headline with glow
                      _GlowHeadline(isWide: isWide),
                      const SizedBox(height: 24),
                      // Claim
                      Text(
                        'Relax. Purr. Sleep.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isWide ? 26 : 20,
                          color: AppColors.gold,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w400,
                          shadows: const [
                            Shadow(color: Color(0x88000000), blurRadius: 8),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Description
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 560),
                        child: Text(
                          'A calming purr experience with sound, vibration and cozy comfort.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isWide ? 18 : 16,
                            color: AppColors.textSecondary,
                            height: 1.7,
                            shadows: const [
                              Shadow(color: Color(0xAA000000), blurRadius: 6),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 52),
                      // CTA Buttons
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
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

class _GlowHeadline extends StatelessWidget {
  final bool isWide;
  const _GlowHeadline({required this.isWide});

  @override
  Widget build(BuildContext context) {
    final fontSize = isWide ? 84.0 : 54.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow layer — blurred copy behind text
        Text(
          'SchnurrPurr',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.gold.withAlpha(60),
            letterSpacing: 2,
            shadows: [
              Shadow(color: AppColors.gold.withAlpha(120), blurRadius: 48),
              Shadow(color: AppColors.primary.withAlpha(80), blurRadius: 80),
            ],
          ),
        ),
        // Actual gradient text
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.gold, Color(0xFFF5C872), AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'SchnurrPurr',
            textAlign: TextAlign.center,
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
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
