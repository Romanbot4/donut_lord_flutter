import 'package:jdonuts/src/core/core.dart';

class ProductDetail extends Entity {
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String imageUrl;
  final double imageAspectRatio;
  final String? description;

  const ProductDetail({
    required super.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.imageUrl,
    required this.imageAspectRatio,
    this.description,
  });
}
