import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class PointsRing extends StatefulWidget {
  final double size;
  final double progress;
  final int totalPoints;
  final Duration delay;

  const PointsRing({
    super.key,
    required this.size,
    required this.progress,
    required this.totalPoints,
    this.delay = Duration.zero,
  });

  @override
  State<PointsRing> createState() => _PointsRingState();
}

class _PointsRingState extends State<PointsRing>
    with SingleTickerProviderStateMixin {
  static const _trackAlpha = 0.04;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.ringSweep,
  );
  late final Animation<double> _sweep = CurvedAnimation(
    parent: _controller,
    curve: AppMotion.entranceCurve,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isAnimating || _controller.value > 0) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.localizations;
    final format = NumberFormat.decimalPattern(strings.localeName);
    final strokeWidth = widget.size * _RingPainter.strokeFactor;

    return Semantics(
      label: '${strings.lblTotalPoints} ${format.format(widget.totalPoints)}',
      child: SizedBox.square(
        dimension: widget.size,
        child: AnimatedBuilder(
          animation: _sweep,
          builder: (context, _) => CustomPaint(
            painter: _RingPainter(
              sweep: widget.progress.clamp(0.0, 1.0) * _sweep.value,
              strokeWidth: strokeWidth,
              trackColor: context.theme.dividerColor.withValues(
                alpha: _trackAlpha,
              ),
              glazeColor: context.theme.colorScheme.primary,
              sprinkleColor: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(strokeWidth),
              child: _Centre(
                points: format.format(
                  (widget.totalPoints * _sweep.value).round(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Centre extends StatelessWidget {
  final String points;

  const _Centre({required this.points});

  @override
  Widget build(BuildContext context) {
    final pink = context.theme.colorScheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppInsets.sm),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.localizations.lblTotalPoints,
                style: context.textTheme.titleSmall?.copyWith(color: pink),
              ),
              Text(
                points,
                style: context.textTheme.headlineLarge?.copyWith(color: pink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double sweep;
  final double strokeWidth;
  final Color trackColor;
  final Color glazeColor;
  final Color sprinkleColor;

  _RingPainter({
    required this.sweep,
    required this.strokeWidth,
    required this.trackColor,
    required this.glazeColor,
    required this.sprinkleColor,
  });

  static const strokeFactor = 0.2;
  static const _startAngle = -math.pi / 2;
  static const _sprinkleStep = math.pi / 9;
  static const _sprinkleOpacity = 0.55;
  static const _startColorLerp = 0.25;
  static const _sprinkleWidthFactor = 0.09;
  static const _sprinkleLengthFactor = 0.28;
  static const _sprinkleOffsetFactor = 0.18;
  static const _sprinkleTilt = 0.9;

  @override
  void paint(Canvas canvas, Size size) {
    final centre = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: centre, radius: radius);

    canvas.drawCircle(
      centre,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
    if (sweep <= 0) return;

    final sweepAngle = sweep * 2 * math.pi;
    final startColor = Color.lerp(glazeColor, sprinkleColor, _startColorLerp)!;
    final capAngle = (strokeWidth / 2) / radius;
    canvas.drawArc(
      rect,
      _startAngle,
      sweepAngle,
      false,
      Paint()
        ..shader = SweepGradient(
          startAngle: 0,
          endAngle: 2 * math.pi,
          transform: GradientRotation(_startAngle - capAngle),
          colors: [startColor, startColor, glazeColor],
          stops: [0, capAngle / math.pi, 1],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth,
    );
    _paintSprinkles(canvas, centre, radius, sweepAngle);
  }

  void _paintSprinkles(
    Canvas canvas,
    Offset centre,
    double radius,
    double sweepAngle,
  ) {
    final paint = Paint()
      ..color = sprinkleColor.withValues(alpha: _sprinkleOpacity)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth * _sprinkleWidthFactor;
    final length = strokeWidth * _sprinkleLengthFactor;
    var index = 0;
    for (var a = _sprinkleStep / 2; a < sweepAngle; a += _sprinkleStep) {
      final angle = _startAngle + a;
      final offset = index.isEven
          ? _sprinkleOffsetFactor
          : -_sprinkleOffsetFactor;
      final point =
          centre +
          Offset(math.cos(angle), math.sin(angle)) *
              (radius + offset * strokeWidth);
      final tilt = angle + (index % 3 - 1) * _sprinkleTilt;
      final half = Offset(math.cos(tilt), math.sin(tilt)) * length / 2;
      canvas.drawLine(point - half, point + half, paint);
      index++;
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.sweep != sweep ||
      old.strokeWidth != strokeWidth ||
      old.trackColor != trackColor ||
      old.glazeColor != glazeColor ||
      old.sprinkleColor != sprinkleColor;
}
