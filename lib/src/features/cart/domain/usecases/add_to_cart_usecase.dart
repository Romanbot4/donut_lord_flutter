import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';
@injectable
class AddToCartUseCase extends UseCase<List<CartLine>, CartLine> {
  final ICartRepository _repository;
  const AddToCartUseCase(this._repository);

  static const maxQuantityPerLine = 99;

  @override
  Future<List<CartLine>> handle(CartLine line) async {
    final lines = [...await _repository.getLines()];
    final index = lines.indexWhere((l) => l.productId == line.productId);
    if (index == -1) {
      lines.add(line);
    } else {
      final merged = lines[index].quantity + line.quantity;
      lines[index] = lines[index].withQuantity(
        merged > maxQuantityPerLine ? maxQuantityPerLine : merged,
      );
    }
    await _repository.saveLines(lines);
    return lines;
  }
}
