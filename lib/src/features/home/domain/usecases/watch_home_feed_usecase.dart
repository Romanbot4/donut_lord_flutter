import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

@injectable
class WatchHomeFeedUseCase {
  final IHomeRepository _repository;
  const WatchHomeFeedUseCase(this._repository);

  Stream<HomeFeed> call() => _repository.watchFeed();
}
