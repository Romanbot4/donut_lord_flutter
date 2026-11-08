import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

class Shop extends Entity {
  final String name;
  final String? title;
  final String address;
  final String? imageUrl;
  final double? imageAspectRatio;
  final Promotion? promotion;

  const Shop({
    required super.id,
    required this.name,
    required this.address,
    this.title,
    this.imageUrl,
    this.imageAspectRatio,
    this.promotion,
  });

  String get displayTitle => title ?? name;
}
