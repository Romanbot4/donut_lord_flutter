import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/product/domain/domain.dart';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

@freezed
sealed class ProductDetailModel with _$ProductDetailModel {
  const ProductDetailModel._();

  const factory ProductDetailModel({
    @JsonKey(fromJson: _idFromJson) required String id,
    required String code,
    required String name,
    required int priceMmk,
    @Default(false) bool isNew,
    required String imageUrl,
    @Default(1.0) double imageAspectRatio,
    String? description,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  ProductDetail toEntity() => ProductDetail(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    imageUrl: imageUrl,
    imageAspectRatio: imageAspectRatio,
    description: description,
  );
}
String _idFromJson(Object? value) => value.toString();
