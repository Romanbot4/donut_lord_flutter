import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

part 'promotion_model.freezed.dart';
part 'promotion_model.g.dart';

@freezed
sealed class PromotionModel with _$PromotionModel {
  const PromotionModel._();

  const factory PromotionModel({
    required String label,
    String? position,
    String? kind,
  }) = _PromotionModel;

  factory PromotionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json);

  static const _fallbackPosition = PromotionPosition.bottomRight;
  Promotion toEntity() => Promotion(
    label: label,
    position: PromotionPosition.values.firstWhere(
      (p) => p.name == position,
      orElse: () => _fallbackPosition,
    ),
    kind: switch (kind) {
      'discount' => PromotionKind.discount,
      'new' => PromotionKind.isNew,
      _ => PromotionKind.info,
    },
  );
}
