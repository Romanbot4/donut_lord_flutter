import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'shop_model.freezed.dart';
part 'shop_model.g.dart';

@freezed
sealed class ShopModel with _$ShopModel {
  const ShopModel._();

  const factory ShopModel({
    @JsonKey(fromJson: idFromJson) required String id,
    required String name,
    String? title,
    required String address,
    String? imageUrl,
    double? imageAspectRatio,
    PromotionModel? promotion,
  }) = _ShopModel;

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Shop toEntity() => Shop(
    id: id,
    name: name,
    title: title,
    address: address,
    imageUrl: imageUrl,
    imageAspectRatio: imageAspectRatio,
    promotion: promotion?.toEntity(),
  );
}
