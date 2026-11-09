import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

abstract final class AppMotion {
  static const fast = Duration(milliseconds: 300);
  static const medium = Duration(milliseconds: 600);

  static const stagger = Duration(milliseconds: 90);

  static const shake = Duration(milliseconds: 450);

  static const shimmer = Duration(milliseconds: 5000);

  static const tierStagger = Duration(milliseconds: 300);

  static const progressFill = Duration(milliseconds: 900);

  static const ringSweep = Duration(milliseconds: 1400);

  static const attentionPulse = Duration(milliseconds: 900);

  static const artworkSlideOffset = 0.25;
  static const contentSlideOffset = 0.3;

  static const pressedScale = 0.96;

  static const entranceCurve = Curves.easeOutCubic;
}

extension EntranceAnimation on Widget {
  Widget slideUpIn({
    required bool enabled,
    Duration delay = Duration.zero,
    double offset = AppMotion.artworkSlideOffset,
  }) {
    if (!enabled) return this;
    return animate(delay: delay)
        .fadeIn(duration: AppMotion.fast)
        .slideY(
          begin: offset,
          end: 0,
          duration: AppMotion.medium,
          curve: AppMotion.entranceCurve,
        );
  }
}
