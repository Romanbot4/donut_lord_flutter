import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

class BottomRoundedBorder extends ShapeBorder {
  final double radius;
  final BorderSide side;

  const BottomRoundedBorder({
    required this.radius,
    this.side = BorderSide.none,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: side.width);

  RRect _shape(Rect rect) => RRect.fromRectAndCorners(
    rect,
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRRect(_shape(rect));

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRRect(_shape(rect).deflate(side.width));

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width == 0) return;

    final inset = -side.strokeAlign * side.width / 2;
    final curve = (radius - inset).clamp(0.0, double.infinity);
    final left = rect.left + inset;
    final right = rect.right - inset;
    final bottom = rect.bottom - inset;

    final edge = Path()
      ..moveTo(left, bottom - curve)
      ..arcToPoint(
        Offset(left + curve, bottom),
        radius: Radius.circular(curve),
        clockwise: false,
      )
      ..lineTo(right - curve, bottom)
      ..arcToPoint(
        Offset(right, bottom - curve),
        radius: Radius.circular(curve),
        clockwise: false,
      );

    canvas.drawPath(edge, side.toPaint());
  }

  @override
  ShapeBorder scale(double t) =>
      BottomRoundedBorder(radius: radius * t, side: side.scale(t));

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) => a is BottomRoundedBorder
      ? BottomRoundedBorder(
          radius: lerpDouble(a.radius, radius, t)!,
          side: BorderSide.lerp(a.side, side, t),
        )
      : super.lerpFrom(a, t);

  @override
  bool operator ==(Object other) =>
      other is BottomRoundedBorder &&
      other.radius == radius &&
      other.side == side;

  @override
  int get hashCode => Object.hash(radius, side);
}
