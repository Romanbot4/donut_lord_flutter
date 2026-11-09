import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/rewards/domain/domain.dart';

@injectable
class RefreshChallengesUseCase extends UseCase<void, void> {
  final IRewardsRepository _repository;
  const RefreshChallengesUseCase(this._repository);

  @override
  Future<void> handle(void param) => _repository.refresh();
}
