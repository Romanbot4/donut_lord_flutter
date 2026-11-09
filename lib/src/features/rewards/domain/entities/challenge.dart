import 'package:jdonuts/src/core/core.dart';

enum ChallengeProgressStyle { donut, arc }

class Challenge extends Entity {
  final String title;
  final int current;
  final int target;
  final int rewardPoints;
  final ChallengeProgressStyle progressStyle;
  final String imageUrl;
  final double imageAspectRatio;

  const Challenge({
    required super.id,
    required this.title,
    required this.current,
    required this.target,
    required this.rewardPoints,
    required this.progressStyle,
    required this.imageUrl,
    required this.imageAspectRatio,
  });

  double get progress => target <= 0 ? 0 : (current / target).clamp(0.0, 1.0);

  bool get isComplete => current >= target;
}
