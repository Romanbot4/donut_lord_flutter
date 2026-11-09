import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/product/data/data.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';

@lazySingleton
class ProductLocalDataSource {
  final AppDatabase _db;

  const ProductLocalDataSource(this._db);

  Stream<ProductDetail?> watchProduct(String id) =>
      (_db.select(_db.menuItems)..where((item) => item.id.equals(id)))
          .watchSingleOrNull()
          .map((row) => row == null ? null : _toEntity(row));

  Future<void> saveProduct(ProductDetailModel product) =>
      _db.into(_db.menuItems).insertOnConflictUpdate(
        MenuItemsCompanion.insert(
          id: product.id,
          code: product.code,
          name: product.name,
          priceMmk: product.priceMmk,
          isNew: product.isNew,
          imageUrl: product.imageUrl,
          imageAspectRatio: product.imageAspectRatio,
          description: Value(product.description),
        ),
      );

  ProductDetail _toEntity(MenuItemRow row) => ProductDetail(
    id: row.id,
    code: row.code,
    name: row.name,
    priceMmk: row.priceMmk,
    isNew: row.isNew,
    imageUrl: row.imageUrl,
    imageAspectRatio: row.imageAspectRatio,
    description: row.description,
  );
}
