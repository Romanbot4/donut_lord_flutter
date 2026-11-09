class ProductPreview {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String imageUrl;
  final double imageAspectRatio;
  final String heroTag;

  const ProductPreview({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.imageUrl,
    required this.imageAspectRatio,
    required this.heroTag,
  });
}
