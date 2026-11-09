part of 'product_detail_cubit.dart';

@freezed
abstract class ProductDetailState with _$ProductDetailState {
  const ProductDetailState._();

  const factory ProductDetailState({
    ProductPreview? preview,
    ProductDetail? product,
    @Default(ProductDetailCubit.minQuantity) int quantity,
    @Default(true) bool isLoading,
    Failure? failure,
  }) = _ProductDetailState;

  int? get unitPriceMmk => product?.priceMmk ?? preview?.priceMmk;

  int? get totalMmk => switch (unitPriceMmk) {
    final price? => price * quantity,
    null => null,
  };
}
