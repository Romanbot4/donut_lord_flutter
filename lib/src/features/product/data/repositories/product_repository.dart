import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/product/data/data.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';

@LazySingleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  final ProductLocalDataSource _local;
  final ProductApiClient _remote;

  const ProductRepository(this._local, this._remote);

  @override
  Stream<ProductDetail?> watchProduct(String id) => _local.watchProduct(id);

  @override
  Future<void> refresh(String id) async {
    final envelope = await _remote.getProduct(id);
    final product = envelope.data;
    if (envelope.error != null || product == null) {
      throw UnknownNetworkError(envelope.error?.message ?? 'Empty product');
    }
    await _local.saveProduct(product);
  }
}
