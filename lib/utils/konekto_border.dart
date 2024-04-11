// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/cupertino.dart';

class KonektoBorder extends Border {
  const KonektoBorder({
    this.top = BorderSide.none,
    this.right = BorderSide.none,
    this.bottom = BorderSide.none,
    this.left = BorderSide.none,
  });

  const KonektoBorder.fromBorderSide(BorderSide side)
      : top = side,
        right = side,
        bottom = side,
        left = side;

  factory KonektoBorder.all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = BorderSide.strokeAlignInside,
  }) {
    final BorderSide side = BorderSide(
        color: color, width: width, style: style, strokeAlign: strokeAlign);
    return KonektoBorder.fromBorderSide(side);
  }

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(4.0);

  final BorderSide top;

  /// The right side of this border.
  final BorderSide right;

  final BorderSide bottom;

  /// The left side of this border.
  final BorderSide left;
}
