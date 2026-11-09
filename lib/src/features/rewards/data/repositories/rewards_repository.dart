import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/rewards/data/data.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

@LazySingleton(as: IRewardsRepository)
class RewardsRepository implements IRewardsRepository {
  final RewardsLocalDataSource _local;
  final RewardsApiClient _remote;

  const RewardsRepository(this._local, this._remote);

  @override
  Stream<List<Challenge>> watchChallenges() async* {
    await _local.seedIfEmpty();
    yield* _local.watchChallenges();
  }

  @override
  Future<void> refresh() async {
    final envelope = await _remote.getChallenges();
    final data = envelope.data;
    if (envelope.error != null || data == null) {
      throw UnknownNetworkError(envelope.error?.message ?? 'Empty challenges');
    }
    await _local.replaceChallenges(data.challenges);
  }
}
