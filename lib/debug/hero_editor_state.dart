import 'package:flutter/foundation.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HeroEditorState — debug-only live positioning tool
//
//  Usage:
//    HeroEditorState state = HeroEditorState();
//    state.selectItem(HeroEditableItem.module);
//    state.moveSelected(5, 0);   // nudge right 5 px
//    state.printValues();        // prints copyable Dart code to the console
// ─────────────────────────────────────────────────────────────────────────────

enum HeroEditableItem { pillow, module, phone }

// ─────────────────────────────────────────────────────────────────────────────
//  Immutable per-item config
// ─────────────────────────────────────────────────────────────────────────────

class HeroItemConfig {
  final double x; // horizontal offset added on top of the computed base
  final double y; // vertical offset added on top of the computed base
  final double scale; // multiplier on top of the computed base size
  final double rotationDeg; // total rotation in degrees

  const HeroItemConfig({
    this.x = 0,
    this.y = 0,
    this.scale = 1.0,
    this.rotationDeg = 0,
  });

  HeroItemConfig copyWith({
    double? x,
    double? y,
    double? scale,
    double? rotationDeg,
  }) {
    return HeroItemConfig(
      x: x ?? this.x,
      y: y ?? this.y,
      scale: scale ?? this.scale,
      rotationDeg: rotationDeg ?? this.rotationDeg,
    );
  }

  @override
  String toString() =>
      'HeroItemConfig(x: $x, y: $y, scale: $scale, rotationDeg: $rotationDeg)';
}

// ─────────────────────────────────────────────────────────────────────────────
//  ChangeNotifier holding the state for all three items
// ─────────────────────────────────────────────────────────────────────────────

class HeroEditorState extends ChangeNotifier {
  // ── currently selected item ─────────────────────────────────────────────
  HeroEditableItem selectedItem = HeroEditableItem.pillow;

  // ── per-item config ──────────────────────────────────────────────────────
  HeroItemConfig pillowConfig = const HeroItemConfig();
  HeroItemConfig moduleConfig = const HeroItemConfig();
  HeroItemConfig phoneConfig = const HeroItemConfig();

  // ── helpers ──────────────────────────────────────────────────────────────

  HeroItemConfig get _selected => switch (selectedItem) {
    HeroEditableItem.pillow => pillowConfig,
    HeroEditableItem.module => moduleConfig,
    HeroEditableItem.phone => phoneConfig,
  };

  void _setSelected(HeroItemConfig cfg) {
    switch (selectedItem) {
      case HeroEditableItem.pillow:
        pillowConfig = cfg;
      case HeroEditableItem.module:
        moduleConfig = cfg;
      case HeroEditableItem.phone:
        phoneConfig = cfg;
    }
    notifyListeners();
  }

  // ── public API ───────────────────────────────────────────────────────────

  void selectItem(HeroEditableItem item) {
    selectedItem = item;
    notifyListeners();
  }

  /// Moves the selected item by [dx] pixels horizontally and [dy] vertically.
  void moveSelected(double dx, double dy) {
    _setSelected(_selected.copyWith(x: _selected.x + dx, y: _selected.y + dy));
  }

  /// Adds [delta] to the scale factor (clamped to [0.1, 5.0]).
  void scaleSelected(double delta) {
    final next = (_selected.scale + delta).clamp(0.1, 5.0);
    _setSelected(_selected.copyWith(scale: next));
  }

  /// Adds [delta] degrees to the rotation (wraps in [-360, 360]).
  void rotateSelected(double delta) {
    var next = _selected.rotationDeg + delta;
    if (next > 360) next -= 360;
    if (next < -360) next += 360;
    _setSelected(_selected.copyWith(rotationDeg: next));
  }

  /// Resets the currently selected item to its defaults.
  void reset() {
    _setSelected(const HeroItemConfig());
  }

  /// Prints copyable Dart-code for all configs to the debug console.
  void printValues() {
    debugPrint('─── HeroEditorState values ───────────────────────────');
    for (final item in HeroEditableItem.values) {
      final cfg = switch (item) {
        HeroEditableItem.pillow => pillowConfig,
        HeroEditableItem.module => moduleConfig,
        HeroEditableItem.phone => phoneConfig,
      };
      final name = item.name;
      debugPrint(
        '${name}Config: HeroItemConfig('
        'x: ${cfg.x.toStringAsFixed(1)}, '
        'y: ${cfg.y.toStringAsFixed(1)}, '
        'scale: ${cfg.scale.toStringAsFixed(3)}, '
        'rotationDeg: ${cfg.rotationDeg.toStringAsFixed(1)})',
      );
    }
    debugPrint('──────────────────────────────────────────────────────');
  }
}
