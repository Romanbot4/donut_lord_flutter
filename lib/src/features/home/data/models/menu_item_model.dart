import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'menu_item_model.freezed.dart';
part 'menu_item_model.g.dart';

@freezed
sealed class MenuItemModel with _$MenuItemModel {
  const MenuItemModel._();

  const factory MenuItemModel({
    @JsonKey(fromJson: idFromJson) required String id,
    required String code,
    required String name,
    required int priceMmk,
    @Default(false) bool isNew,
    required String imageUrl,
    @Default(1.0) double imageAspectRatio,
    PromotionModel? promotion,
  }) = _MenuItemModel;

  factory MenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemModelFromJson(json);

  MenuItem toEntity() => MenuItem(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    imageUrl: imageUrl,
    imageAspectRatio: imageAspectRatio,
    promotion: promotion?.toEntity(),
  );
}
String idFromJson(Object? value) => value.toString();
