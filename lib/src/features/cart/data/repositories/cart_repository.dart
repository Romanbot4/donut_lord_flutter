import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/cart/data/data.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';

@Injectable(as: ICartRepository)
class CartRepository implements ICartRepository {
  final ICartLocalStorage _storage;
  const CartRepository(this._storage);

  @override
  Future<List<CartLine>> getLines() async =>
      (await _storage.getLines()).map((m) => m.toEntity()).toList();

  @override
  Future<void> saveLines(List<CartLine> lines) =>
      _storage.saveLines(lines.map(CartLineModel.fromEntity).toList());

  @override
  Future<void> clear() => _storage.clear();
}
