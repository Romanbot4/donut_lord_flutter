import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
sealed class ChallengeModel with _$ChallengeModel {
  const ChallengeModel._();

  const factory ChallengeModel({
    required String id,
    required String title,
    required int current,
    required int target,
    required int rewardPoints,
    String? progressStyle,
    required String imageUrl,
    @Default(1.0) double imageAspectRatio,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  Challenge toEntity() => Challenge(
    id: id,
    title: title,
    current: current,
    target: target,
    rewardPoints: rewardPoints,
    progressStyle: ChallengeProgressStyle.values.firstWhere(
      (s) => s.name == progressStyle,
      orElse: () => ChallengeProgressStyle.arc,
    ),
    imageUrl: imageUrl,
    imageAspectRatio: imageAspectRatio,
  );
}

@freezed
sealed class ChallengesModel with _$ChallengesModel {
  const factory ChallengesModel({
    @Default([]) List<ChallengeModel> challenges,
  }) = _ChallengesModel;

  factory ChallengesModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengesModelFromJson(json);
}
