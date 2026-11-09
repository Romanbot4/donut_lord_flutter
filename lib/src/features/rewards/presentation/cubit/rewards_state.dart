part of 'rewards_cubit.dart';

@freezed
abstract class RewardsState with _$RewardsState {
  const RewardsState._();

  const factory RewardsState({
    Member? member,
    List<Challenge>? challenges,
    Failure? failure,
  }) = _RewardsState;

  bool get isLoadingChallenges => challenges == null && failure == null;
}
