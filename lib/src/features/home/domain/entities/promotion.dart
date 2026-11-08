enum PromotionPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

enum PromotionKind { discount, isNew, info }

class Promotion {
  final String label;
  final PromotionPosition position;
  final PromotionKind kind;

  const Promotion({
    required this.label,
    required this.position,
    required this.kind,
  });
}
