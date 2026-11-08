import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'home_feed_model.freezed.dart';
part 'home_feed_model.g.dart';

@freezed
sealed class HomeFeedModel with _$HomeFeedModel {
  const HomeFeedModel._();

  const factory HomeFeedModel({
    @Default([]) List<ShopModel> shops,
    @Default([]) List<MenuSectionModel> menuSections,
  }) = _HomeFeedModel;

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) =>
      _$HomeFeedModelFromJson(json);

  HomeFeed toEntity() => HomeFeed(
    shops: shops.map((shop) => shop.toEntity()).toList(),
    menuSections: menuSections.map((section) => section.toEntity()).toList(),
  );
}
