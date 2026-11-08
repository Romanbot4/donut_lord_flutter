import 'package:jdonuts/src/core/core.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

class MenuSection extends Entity {
  final String title;
  final double itemAspectRatio;
  final List<MenuItem> items;

  const MenuSection({
    required super.id,
    required this.title,
    required this.itemAspectRatio,
    required this.items,
  });
}
