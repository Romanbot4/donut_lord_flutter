import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';

@injectable
class GetCartUseCase extends UseCase<List<CartLine>, void> {
  final ICartRepository _repository;
  const GetCartUseCase(this._repository);

  @override
  Future<List<CartLine>> handle(void param) => _repository.getLines();
}
