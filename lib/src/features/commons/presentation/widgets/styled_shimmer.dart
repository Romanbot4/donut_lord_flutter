import 'package:flutter/material.dart';
import 'package:jdonuts/src/features/commons/presentation/presentation.dart';

class StyledShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final double radius;
  final BoxShape shape;

  const StyledShimmer({
    super.key,
    this.width,
    this.height,
    this.radius = AppRadius.md,
    this.shape = BoxShape.rectangle,
  });

  @override
  State<StyledShimmer> createState() => _StyledShimmerState();
}

class _StyledShimmerState extends State<StyledShimmer>
    with SingleTickerProviderStateMixin {
  static const _sweepStart = -3.0;
  static const _sweepEnd = -1.0;
  static const _sweepDistance = 4.0;

  late final _controller = AnimationController(
    vsync: this,
    duration: AppMotion.shimmer,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.disableAnimationsOf(context)
        ? _controller.stop()
        : _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const base = AppColors.neutral100;
    const highlight = AppColors.neutral50;
    final isCircle = widget.shape == BoxShape.circle;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        decoration: BoxDecoration(
          shape: widget.shape,
          borderRadius: isCircle
              ? null
              : BorderRadius.circular(widget.radius),
          gradient: LinearGradient(
            begin: Alignment(_sweepStart + _controller.value * _sweepDistance, 0),
            end: Alignment(_sweepEnd + _controller.value * _sweepDistance, 0),
            colors: const [base, highlight, base],
          ),
        ),
      ),
    );
  }
}
