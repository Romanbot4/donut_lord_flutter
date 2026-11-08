import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final HomeLocalDataSource _local;
  final HomeApiClient _remote;

  const HomeRepository(this._local, this._remote);

  @override
  Stream<HomeFeed> watchFeed() async* {
    await _local.seedIfEmpty();
    yield* _local.watchFeed();
  }

  @override
  Future<void> refresh() async {
    final envelope = await _remote.getHomeFeed();
    final feed = envelope.data;
    if (envelope.error != null || feed == null) {
      throw UnknownNetworkError(envelope.error?.message ?? 'Empty home feed');
    }
    await _local.replaceFeed(feed);
  }
}
