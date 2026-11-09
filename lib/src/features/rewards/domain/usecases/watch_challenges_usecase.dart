import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

@injectable
class WatchChallengesUseCase {
  final IRewardsRepository _repository;
  const WatchChallengesUseCase(this._repository);

  Stream<List<Challenge>> call() => _repository.watchChallenges();
}
