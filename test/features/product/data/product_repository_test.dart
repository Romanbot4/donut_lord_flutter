import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/product/data/data.dart';

import '../../../support/seed_bundle.dart';

class _FakeProductApiClient implements ProductApiClient {
  @override
  Future<ApiEnvelope<ProductDetailModel>> getProduct(String id) async =>
      ApiEnvelope(
        data: ProductDetailModel(
          id: id,
          code: 'JD022123',
          name: 'Coconut Donut',
          priceMmk: 3500,
          imageUrl: 'https://cdn.test/coconut.png',
          description: 'Fresh from the server',
        ),
      );
}

class _FakeHomeApiClient implements HomeApiClient {
  @override
  Future<ApiEnvelope<HomeFeedModel>> getHomeFeed() async =>
      ApiEnvelope(data: HomeFeedModel.fromJson(seedFeed));
}

void main() {
  late AppDatabase db;
  late HomeRepository home;
  late ProductRepository products;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    home = HomeRepository(
      HomeLocalDataSource(db, SeedBundle()),
      _FakeHomeApiClient(),
    );
    products = ProductRepository(
      ProductLocalDataSource(db),
      _FakeProductApiClient(),
    );
    await home.watchFeed().first;
  });

  tearDown(() => db.close());

  test('reads a seeded product with its seeded description', () async {
    final product = await products.watchProduct('coconut').first;

    expect(product?.name, 'Coconut Donut');
    expect(product?.description, 'Soft and sweet');
  });

  test('refreshing saves the server product over the cached one', () async {
    await products.refresh('coconut');
    final product = await products.watchProduct('coconut').first;

    expect(product?.priceMmk, 3500);
    expect(product?.description, 'Fresh from the server');
  });

  test(
    'fills in seeded descriptions missing from an existing database',
    () async {
      await db
          .update(db.menuItems)
          .write(const MenuItemsCompanion(description: Value(null)));

      await home.watchFeed().first;
      final product = await products.watchProduct('coconut').first;

      expect(product?.description, 'Soft and sweet');
    },
  );

  test('refreshing the home feed keeps product descriptions', () async {
    await home.refresh();
    final product = await products.watchProduct('coconut').first;

    expect(product?.description, 'Soft and sweet');
  });
}
