import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/home/data/data.dart';

const _seed = {
  'shops': [
    {'id': 'central', 'name': 'Central', 'address': 'Yangon'},
  ],
  'menuSections': [
    {
      'id': 'popular',
      'title': 'Popular',
      'itemAspectRatio': 0.75,
      'items': [
        {
          'id': 'coconut',
          'code': 'JD022123',
          'name': 'Coconut Donut',
          'priceMmk': 3200,
          'imageUrl': 'assets/seed/images/coconut.png',
          'promotion': {'label': '20% off', 'kind': 'discount'},
        },
      ],
    },
  ],
};

const _remoteFeed = HomeFeedModel(
  menuSections: [MenuSectionModel(id: 'seasonal', title: 'Seasonal specials')],
);

class _SeedBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(utf8.encode(jsonEncode(_seed)));

  @override
  Future<String> loadString(String key, {bool cache = true}) async =>
      jsonEncode(_seed);
}

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
    repository = HomeRepository(HomeLocalDataSource(db, _SeedBundle()), api);
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
