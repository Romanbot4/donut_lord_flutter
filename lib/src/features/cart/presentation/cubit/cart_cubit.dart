import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';

part 'cart_state.dart';
part 'cart_cubit.freezed.dart';
@lazySingleton
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCart;
  final AddToCartUseCase _addToCart;
  final ClearCartUseCase _clearCart;

  CartCubit(this._getCart, this._addToCart, this._clearCart)
    : super(const CartState());

  Future<void> load() async {
    final result = await _getCart(null);
    if (result.isSuccess) emit(CartState(lines: result.data));
  }
  Future<bool> add(CartLine line) async {
    final result = await _addToCart(line);
    if (result.isSuccess) emit(CartState(lines: result.data));
    return result.isSuccess;
  }

  Future<void> clear() async {
    await _clearCart(null);
    emit(const CartState());
  }
}
