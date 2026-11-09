import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';
import 'package:jdonuts/src/features/cart/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';
import 'package:jdonuts/src/features/product/presentation/presentation.dart';

const _preview = ProductPreview(
  id: 'coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  imageUrl: 'assets/seed/images/coconut.png',
  imageAspectRatio: 1,
  heroTag: 'menu-popular-coconut',
);

class _EmptyProductRepository implements IProductRepository {
  @override
  Stream<ProductDetail?> watchProduct(String id) => Stream.value(null);

  @override
  Future<void> refresh(String id) async {}
}

class _MemoryCartRepository implements ICartRepository {
  List<CartLine> lines = [];

  @override
  Future<List<CartLine>> getLines() async => lines;

  @override
  Future<void> saveLines(List<CartLine> value) async => lines = value;

  @override
  Future<void> clear() async => lines = [];
}

class _SilentSnackShower implements ISnackShower {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _UnusedLocalization implements ILocalization {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

ProductDetailCubit _buildCubit() {
  final products = _EmptyProductRepository();
  final carts = _MemoryCartRepository();
  return ProductDetailCubit(
    WatchProductUseCase(products),
    RefreshProductUseCase(products),
    CartCubit(
      GetCartUseCase(carts),
      AddToCartUseCase(carts),
      ClearCartUseCase(carts),
    ),
    _SilentSnackShower(),
    _UnusedLocalization(),
  );
}

void main() {
  late ProductDetailCubit cubit;

  setUp(() async {
    cubit = _buildCubit();
    await cubit.load(_preview.id, preview: _preview);
  });

  tearDown(() => cubit.close());

  test('starts at the minimum quantity and cannot go below it', () {
    cubit.decrement();

    expect(cubit.state.quantity, ProductDetailCubit.minQuantity);
  });

  test('cannot go above the maximum quantity', () {
    for (var i = 0; i < ProductDetailCubit.maxQuantity + 5; i++) {
      cubit.increment();
    }

    expect(cubit.state.quantity, ProductDetailCubit.maxQuantity);
  });

  test('the total is quantity times the unit price', () {
    cubit
      ..increment()
      ..increment();

    expect(cubit.state.totalMmk, 3 * _preview.priceMmk);
  });
}
