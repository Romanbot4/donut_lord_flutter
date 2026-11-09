import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

class ChallengeArtwork extends StatefulWidget {
  final Challenge challenge;
  final Duration delay;

  const ChallengeArtwork({
    super.key,
    required this.challenge,
    this.delay = Duration.zero,
  });

  @override
  State<ChallengeArtwork> createState() => _ChallengeArtworkState();
}

class _ChallengeArtworkState extends State<ChallengeArtwork>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.progressFill,
  );
  late final Animation<double> _curve = CurvedAnimation(
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
    final challenge = widget.challenge;
    final image = StyledImage(challenge.imageUrl, fit: BoxFit.contain);

    return AspectRatio(
      aspectRatio: challenge.imageAspectRatio,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, _) {
          final fraction = challenge.progress * _curve.value;
          return switch (challenge.progressStyle) {
            ChallengeProgressStyle.donut => _DonutProgress(
              image: image,
              fraction: fraction,
            ),
            ChallengeProgressStyle.arc => _ArcProgress(
              image: image,
              fraction: fraction,
            ),
          };
        },
      ),
    );
  }
}

class _DonutProgress extends StatelessWidget {
  final Widget image;
  final double fraction;

  const _DonutProgress({required this.image, required this.fraction});

  static const _fadedOpacity = 0.35;

  static const _greyscale = ColorFilter.matrix([
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0, 0, 0, 1, 0, //
  ]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: _fadedOpacity,
          child: ColorFiltered(colorFilter: _greyscale, child: image),
        ),
        if (fraction > 0)
          ClipPath(clipper: _PieClipper(fraction), child: image),
      ],
    );
  }
}

class _PieClipper extends CustomClipper<Path> {
  final double fraction;

  const _PieClipper(this.fraction);

  @override
  Path getClip(Size size) {
    final rect = Offset.zero & size;
    if (fraction >= 1) return Path()..addRect(rect);
    final centre = rect.center;
    return Path()
      ..moveTo(centre.dx, centre.dy)
      ..arcTo(
        Rect.fromCircle(center: centre, radius: size.longestSide),
        -math.pi / 2,
        2 * math.pi * fraction,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(_PieClipper oldClipper) => oldClipper.fraction != fraction;
}

class _ArcProgress extends StatelessWidget {
  final Widget image;
  final double fraction;

  const _ArcProgress({required this.image, required this.fraction});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _ArcPainter(
        fraction: fraction,
        trackColor: context.theme.dividerColor,
        fillColor: AppColors.accentOrange,
      ),
      child: image,
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double fraction;
  final Color trackColor;
  final Color fillColor;

  const _ArcPainter({
    required this.fraction,
    required this.trackColor,
    required this.fillColor,
  });

  static const _radiusFactor = 0.42;
  static const _centreYFactor = 0.5;
  static const _strokeFactor = 0.07;

  @override
  void paint(Canvas canvas, Size size) {
    final centre = Offset(size.width / 2, size.height * _centreYFactor);
    final rect = Rect.fromCircle(
      center: centre,
      radius: size.width * _radiusFactor,
    );
    Paint stroke(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * _strokeFactor;

    canvas.drawArc(rect, math.pi, math.pi, false, stroke(trackColor));
    if (fraction > 0) {
      canvas.drawArc(
        rect,
        math.pi,
        math.pi * fraction,
        false,
        stroke(fillColor),
      );
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.fraction != fraction ||
      old.trackColor != trackColor ||
      old.fillColor != fillColor;
}
