import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/home/data/data.dart';

import '../../../support/seed_bundle.dart';

const _remoteFeed = HomeFeedModel(
  menuSections: [MenuSectionModel(id: 'seasonal', title: 'Seasonal specials')],
);

class _FakeHomeApiClient implements HomeApiClient {
  bool failNext = false;

  @override
  Future<ApiEnvelope<HomeFeedModel>> getHomeFeed() async {
    if (failNext) throw Exception('offline');
    return const ApiEnvelope(data: _remoteFeed);
  }
}

void main() {
  late AppDatabase db;
  late _FakeHomeApiClient api;
  late HomeRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    api = _FakeHomeApiClient();
    repository = HomeRepository(HomeLocalDataSource(db, SeedBundle()), api);
  });

  tearDown(() => db.close());

  test('seeds the database from the bundled feed on first watch', () async {
    final feed = await repository.watchFeed().first;

    expect(feed.shops.single.name, 'Central');
    expect(feed.menuSections.single.items.single.name, 'Coconut Donut');
    expect(feed.menuSections.single.items.single.promotion?.label, '20% off');
  });

  test('refreshing replaces the cached feed and the stream emits it', () async {
    await repository.watchFeed().first;

    await repository.refresh();
    final feed = await repository.watchFeed().first;

    expect(feed.menuSections.single.title, 'Seasonal specials');
    expect(feed.shops, isEmpty);
  });

  test('a failed refresh keeps the cached feed', () async {
    await repository.watchFeed().first;
    api.failNext = true;

    await expectLater(repository.refresh(), throwsException);
    final feed = await repository.watchFeed().first;

    expect(feed.menuSections.single.title, 'Popular');
  });
}
