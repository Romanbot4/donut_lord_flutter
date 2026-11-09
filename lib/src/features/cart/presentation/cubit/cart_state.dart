part of 'cart_cubit.dart';

@freezed
abstract class CartState with _$CartState {
  const CartState._();

  const factory CartState({@Default([]) List<CartLine> lines}) = _CartState;
  int get itemCount => lines.fold(0, (sum, line) => sum + line.quantity);

  int get totalMmk => lines.fold(0, (sum, line) => sum + line.totalMmk);

  bool get isEmpty => lines.isEmpty;
}
