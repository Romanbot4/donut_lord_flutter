import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

part 'rewards_state.dart';
part 'rewards_cubit.freezed.dart';

@injectable
class RewardsCubit extends Cubit<RewardsState> {
  final WatchMemberUseCase _watchMember;
  final WatchChallengesUseCase _watchChallenges;
  final RefreshChallengesUseCase _refreshChallenges;
  final _subscriptions = <StreamSubscription<Object?>>[];

  RewardsCubit(
    this._watchMember,
    this._watchChallenges,
    this._refreshChallenges,
  ) : super(const RewardsState());

  Future<void> load() async {
    await _cancelSubscriptions();
    emit(state.copyWith(failure: null));
    _subscriptions
      ..add(
        _watchMember().listen((member) => emit(state.copyWith(member: member))),
      )
      ..add(
        _watchChallenges().listen(
          (challenges) => emit(state.copyWith(challenges: challenges)),
          onError: (_) => emit(state.copyWith(failure: Failure.unkown())),
        ),
      );
    await _refreshChallenges(null);
  }

  Future<void> _cancelSubscriptions() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
  }

  @override
  Future<void> close() async {
    await _cancelSubscriptions();
    return super.close();
  }
}
