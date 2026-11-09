import 'package:jdonuts/src/features/cart/domain/domain.dart';
abstract interface class ICartRepository {
  Future<List<CartLine>> getLines();

  Future<void> saveLines(List<CartLine> lines);

  Future<void> clear();
}
