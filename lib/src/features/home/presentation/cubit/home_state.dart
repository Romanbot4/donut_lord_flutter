part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    HomeFeed? feed,
    Member? member,
    Failure? loadFailure,
    Failure? refreshFailure,
    @Default(false) bool isRefreshing,
    @Default(false) bool isOffline,
  }) = _HomeState;

  bool get isLoading => feed == null && loadFailure == null;
}
