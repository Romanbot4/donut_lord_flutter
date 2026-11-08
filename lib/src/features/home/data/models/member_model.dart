import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
sealed class MemberModel with _$MemberModel {
  const MemberModel._();

  const factory MemberModel({
    required String id,
    required String tier,
    required int totalPoints,
    required int pointsToNextTier,
    required double progressToNextTier,
    required int unreadNotifications,
    required int availableRewards,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Member toEntity() => Member(
    tier: MemberTier.values.asNameMap()[tier] ?? MemberTier.bronze,
    totalPoints: totalPoints,
    pointsToNextTier: pointsToNextTier,
    progressToNextTier: progressToNextTier,
    unreadNotifications: unreadNotifications,
    availableRewards: availableRewards,
  );
}
