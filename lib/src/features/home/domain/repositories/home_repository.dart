import 'package:jdonuts/src/features/home/domain/domain.dart';

abstract interface class IHomeRepository {
  Stream<HomeFeed> watchFeed();

  Future<void> refresh();
}
