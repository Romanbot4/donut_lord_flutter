import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/cart/domain/domain.dart';

part 'cart_line_model.freezed.dart';
part 'cart_line_model.g.dart';

@freezed
sealed class CartLineModel with _$CartLineModel {
  const CartLineModel._();

  const factory CartLineModel({
    required String productId,
    required String name,
    required int unitPriceMmk,
    required String imageUrl,
    required int quantity,
  }) = _CartLineModel;

  factory CartLineModel.fromJson(Map<String, dynamic> json) =>
      _$CartLineModelFromJson(json);

  factory CartLineModel.fromEntity(CartLine line) => CartLineModel(
    productId: line.productId,
    name: line.name,
    unitPriceMmk: line.unitPriceMmk,
    imageUrl: line.imageUrl,
    quantity: line.quantity,
  );

  CartLine toEntity() => CartLine(
    productId: productId,
    name: name,
    unitPriceMmk: unitPriceMmk,
    imageUrl: imageUrl,
    quantity: quantity,
  );
}
