import 'package:jdonuts/src/features/product/domain/domain.dart';

abstract interface class IProductRepository {
  Stream<ProductDetail?> watchProduct(String id);

  Future<void> refresh(String id);
}
