import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final WatchHomeFeedUseCase _watchFeed;
  final WatchMemberUseCase _watchMember;
  final RefreshHomeFeedUseCase _refreshFeed;
  final IConnectivity _connectivity;
  final _subscriptions = <StreamSubscription<Object?>>[];

  HomeCubit(
    this._watchFeed,
    this._watchMember,
    this._refreshFeed,
    this._connectivity,
  ) : super(const HomeState());

  Future<void> start() async {
    _watchLocalData();
    _subscriptions.add(_connectivity.onlineChanges.listen(_onOnlineChanged));
    await _onOnlineChanged(await _connectivity.isOnline());
  }

  Future<void> retry() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    emit(state.copyWith(loadFailure: null));
    await start();
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true, refreshFailure: null));
    final result = await _refreshFeed(null);
    if (isClosed) return;
    emit(
      state.copyWith(
        isRefreshing: false,
        refreshFailure: result.isFailure && !state.isOffline
            ? result.failure
            : null,
      ),
    );
  }

  void _watchLocalData() {
    _subscriptions
      ..add(
        _watchFeed().listen(
          (feed) => emit(state.copyWith(feed: feed, loadFailure: null)),
          onError: (_) => emit(state.copyWith(loadFailure: Failure.unkown())),
        ),
      )
      ..add(
        _watchMember().listen((member) => emit(state.copyWith(member: member))),
      );
  }

  Future<void> _onOnlineChanged(bool isOnline) async {
    emit(state.copyWith(isOffline: !isOnline));
    if (isOnline) await refresh();
  }

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
