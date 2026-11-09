import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

Challenge _challenge({required int current, required int target}) => Challenge(
  id: 'id',
  title: 'title',
  current: current,
  target: target,
  rewardPoints: 100,
  progressStyle: ChallengeProgressStyle.donut,
  imageUrl: 'image.png',
  imageAspectRatio: 1,
);

void main() {
  test('a challenge at its target is complete with full progress', () {
    final challenge = _challenge(current: 4, target: 4);

    expect(challenge.isComplete, isTrue);
    expect(challenge.progress, 1);
  });

  test('progress is the share of the target reached', () {
    expect(_challenge(current: 1, target: 4).progress, 0.25);
    expect(_challenge(current: 9, target: 12).progress, 0.75);
    expect(_challenge(current: 9, target: 12).isComplete, isFalse);
  });

  test('progress never goes past full or divides by zero', () {
    expect(_challenge(current: 6, target: 4).progress, 1);
    expect(_challenge(current: 3, target: 0).progress, 0);
  });
}
