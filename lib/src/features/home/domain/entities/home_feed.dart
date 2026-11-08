import 'package:jdonuts/src/features/home/domain/domain.dart';

class HomeFeed {
  final List<Shop> shops;
  final List<MenuSection> menuSections;

  const HomeFeed({required this.shops, required this.menuSections});
}
