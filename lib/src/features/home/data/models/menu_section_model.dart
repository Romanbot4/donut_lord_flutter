import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'menu_section_model.freezed.dart';
part 'menu_section_model.g.dart';

@freezed
sealed class MenuSectionModel with _$MenuSectionModel {
  const MenuSectionModel._();

  const factory MenuSectionModel({
    @JsonKey(fromJson: idFromJson) required String id,
    required String title,
    @Default(1.0) double itemAspectRatio,
    @Default([]) List<MenuItemModel> items,
  }) = _MenuSectionModel;

  factory MenuSectionModel.fromJson(Map<String, dynamic> json) =>
      _$MenuSectionModelFromJson(json);

  MenuSection toEntity() => MenuSection(
    id: id,
    title: title,
    itemAspectRatio: itemAspectRatio,
    items: items.map((item) => item.toEntity()).toList(),
  );
}
