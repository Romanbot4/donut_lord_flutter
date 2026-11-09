import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';

@injectable
class RefreshProductUseCase extends UseCase<void, String> {
  final IProductRepository _repository;
  const RefreshProductUseCase(this._repository);

  @override
  Future<void> handle(String id) => _repository.refresh(id);
}
