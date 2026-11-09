import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';

@injectable
class ClearCartUseCase extends UseCase<void, void> {
  final ICartRepository _repository;
  const ClearCartUseCase(this._repository);

  @override
  Future<void> handle(void param) => _repository.clear();
}
