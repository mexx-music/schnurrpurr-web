import 'package:flutter/material.dart';
import 'hero_editor_state.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HeroEditorOverlay
//
//  A floating debug panel that lets you nudge, scale and rotate each hero
//  product in real time.  Wrap it around your HeroSection and set
//  kHeroEditorEnabled = true to activate it.
//
//  Example (see hero_section.dart integration):
//
//    Stack(
//      children: [
//        HeroSection(),
//        if (kHeroEditorEnabled)
//          HeroEditorOverlay(state: _editorState),
//      ],
//    )
// ─────────────────────────────────────────────────────────────────────────────

class HeroEditorOverlay extends StatefulWidget {
  final HeroEditorState state;
  const HeroEditorOverlay({super.key, required this.state});

  @override
  State<HeroEditorOverlay> createState() => _HeroEditorOverlayState();
}

class _HeroEditorOverlayState extends State<HeroEditorOverlay> {
  // Whether the panel body is collapsed (only the drag handle is visible).
  bool _collapsed = false;

  // Current drag offset of the floating panel.
  Offset _panelOffset = const Offset(16, 80);

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    widget.state.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() => setState(() {});

  // ─── build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Floating draggable panel ──────────────────────────────────────
        Positioned(
          left: _panelOffset.dx,
          top: _panelOffset.dy,
          child: _buildPanel(context),
        ),
      ],
    );
  }

  Widget _buildPanel(BuildContext context) {
    final state = widget.state;
    final cfg = switch (state.selectedItem) {
      HeroEditableItem.pillow => state.pillowConfig,
      HeroEditableItem.module => state.moduleConfig,
      HeroEditableItem.phone => state.phoneConfig,
    };

    return GestureDetector(
      // Drag the entire panel.
      onPanUpdate: (d) => setState(() => _panelOffset += d.delta),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 220,
          decoration: BoxDecoration(
            color: const Color(0xDD111318),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x44C9A84C), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Title bar ──────────────────────────────────────────
              _buildTitleBar(),

              if (!_collapsed) ...[
                const Divider(color: Color(0x33C9A84C), height: 1),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Item selector ─────────────────────────────
                      _buildItemSelector(state),
                      const SizedBox(height: 12),

                      // ── Current values readout ────────────────────
                      _buildReadout(cfg),
                      const SizedBox(height: 10),

                      // ── Directional nudge ─────────────────────────
                      _buildNudgePad(state),
                      const SizedBox(height: 8),

                      // ── Scale ─────────────────────────────────────
                      _buildRow('Size', [
                        _btn('+', () => state.scaleSelected(0.05)),
                        _btn('−', () => state.scaleSelected(-0.05)),
                      ]),
                      const SizedBox(height: 6),

                      // ── Rotation ──────────────────────────────────
                      _buildRow('Rot', [
                        _btn('+1°', () => state.rotateSelected(1)),
                        _btn('−1°', () => state.rotateSelected(-1)),
                      ]),
                      const SizedBox(height: 10),

                      const Divider(color: Color(0x22C9A84C), height: 1),
                      const SizedBox(height: 8),

                      // ── Reset + Copy ──────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: _actionBtn(
                              'Reset',
                              Icons.refresh,
                              () => state.reset(),
                              color: const Color(0xFFD9534F),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _actionBtn(
                              'Copy',
                              Icons.copy,
                              () => state.printValues(),
                              color: const Color(0xFFC9A84C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ─── sub-widgets ─────────────────────────────────────────────────────────

  Widget _buildTitleBar() {
    return GestureDetector(
      // Tap to collapse/expand; drag is handled by parent GestureDetector.
      onTap: () => setState(() => _collapsed = !_collapsed),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: Row(
          children: [
            const Icon(Icons.tune, color: Color(0xFFC9A84C), size: 14),
            const SizedBox(width: 7),
            const Expanded(
              child: Text(
                'Hero Editor',
                style: TextStyle(
                  color: Color(0xFFC9A84C),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            Icon(
              _collapsed ? Icons.expand_more : Icons.expand_less,
              color: const Color(0x88C9A84C),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemSelector(HeroEditorState state) {
    return Row(
      children: HeroEditableItem.values.map((item) {
        final selected = state.selectedItem == item;
        return Expanded(
          child: GestureDetector(
            onTap: () => state.selectItem(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFC9A84C).withAlpha(40)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFC9A84C)
                      : const Color(0x33C9A84C),
                  width: 1,
                ),
              ),
              child: Text(
                _itemLabel(item),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected
                      ? const Color(0xFFC9A84C)
                      : const Color(0x99C9A84C),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReadout(HeroItemConfig cfg) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(60),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _readoutLine('x', cfg.x.toStringAsFixed(1)),
          _readoutLine('y', cfg.y.toStringAsFixed(1)),
          _readoutLine('scale', cfg.scale.toStringAsFixed(3)),
          _readoutLine('rot°', cfg.rotationDeg.toStringAsFixed(1)),
        ],
      ),
    );
  }

  Widget _readoutLine(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0x88FFFFFF), fontSize: 10),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildNudgePad(HeroEditorState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ↑
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_btn('↑', () => state.moveSelected(0, -5))],
        ),
        const SizedBox(height: 2),
        // ← ↓ →
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btn('←', () => state.moveSelected(-5, 0)),
            const SizedBox(width: 4),
            _btn('↓', () => state.moveSelected(0, 5)),
            const SizedBox(width: 4),
            _btn('→', () => state.moveSelected(5, 0)),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(String label, List<Widget> buttons) {
    return Row(
      children: [
        SizedBox(
          width: 28,
          child: Text(
            label,
            style: const TextStyle(color: Color(0x88FFFFFF), fontSize: 10),
          ),
        ),
        const SizedBox(width: 4),
        ...buttons.map(
          (b) => Padding(padding: const EdgeInsets.only(right: 4), child: b),
        ),
      ],
    );
  }

  Widget _btn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0x22C9A84C),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0x33C9A84C)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xCCC9A84C),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _actionBtn(
    String label,
    IconData icon,
    VoidCallback onTap, {
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withAlpha(80)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 12),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── helpers ─────────────────────────────────────────────────────────────

  String _itemLabel(HeroEditableItem item) => switch (item) {
    HeroEditableItem.pillow => 'Pillow',
    HeroEditableItem.module => 'Module',
    HeroEditableItem.phone => 'Phone',
  };
}
