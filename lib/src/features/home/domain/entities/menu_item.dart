import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

class MenuItem extends Entity {
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String imageUrl;
  final double imageAspectRatio;
  final Promotion? promotion;

  const MenuItem({
    required super.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.imageUrl,
    required this.imageAspectRatio,
    this.promotion,
  });
}
