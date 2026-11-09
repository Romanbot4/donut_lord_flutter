import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';

@injectable
class WatchProductUseCase {
  final IProductRepository _repository;
  const WatchProductUseCase(this._repository);

  Stream<ProductDetail?> call(String id) => _repository.watchProduct(id);
}
