import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';
import 'package:jdonuts/src/features/cart/presentation/presentation.dart';
import 'package:jdonuts/src/features/commons/domain/domain.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';

part 'product_detail_state.dart';
part 'product_detail_cubit.freezed.dart';

@injectable
class ProductDetailCubit extends Cubit<ProductDetailState> {
  final WatchProductUseCase _watchProduct;
  final RefreshProductUseCase _refreshProduct;
  final CartCubit _cart;
  final ISnackShower _snackShower;
  final ILocalization _localization;

  ProductDetailCubit(
    this._watchProduct,
    this._refreshProduct,
    this._cart,
    this._snackShower,
    this._localization,
  ) : super(const ProductDetailState());

  static const minQuantity = 1;
  static const maxQuantity = 99;

  late String _productId;
  StreamSubscription<ProductDetail?>? _subscription;

  Future<void> load(String productId, {ProductPreview? preview}) async {
    _productId = productId;
    emit(state.copyWith(preview: preview, isLoading: true, failure: null));
    await _subscription?.cancel();
    _subscription = _watchProduct(productId).listen(
      (product) => emit(state.copyWith(product: product ?? state.product)),
    );

    final result = await _refreshProduct(productId);
    if (isClosed) return;
    emit(
      state.copyWith(
        isLoading: false,
        failure: result.isFailure ? result.failure : null,
      ),
    );
  }

  Future<void> retry() => load(_productId, preview: state.preview);

  void increment() {
    if (state.quantity < maxQuantity) {
      emit(state.copyWith(quantity: state.quantity + 1));
    }
  }

  void decrement() {
    if (state.quantity > minQuantity) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  Future<bool> addToCart() async {
    final name = state.product?.name ?? state.preview?.name;
    final price = state.unitPriceMmk;
    final imageUrl = state.product?.imageUrl ?? state.preview?.imageUrl;
    if (name == null || price == null || imageUrl == null) return false;

    final saved = await _cart.add(
      CartLine(
        productId: _productId,
        name: name,
        unitPriceMmk: price,
        imageUrl: imageUrl,
        quantity: state.quantity,
      ),
    );
    final strings = _localization.localizations;
    saved
        ? _snackShower.success(
            message: strings.lblAddedToCart(state.quantity, name),
          )
        : _snackShower.error(message: strings.lblAddToCartFailed);
    return saved;
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
