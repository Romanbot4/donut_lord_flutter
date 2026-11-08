import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

@injectable
class RefreshHomeFeedUseCase extends UseCase<void, void> {
  final IHomeRepository _repository;
  const RefreshHomeFeedUseCase(this._repository);

  @override
  Future<void> handle(void param) => _repository.refresh();
}
