import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/rewards/data/data.dart';

const seedFeed = {
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

const seedDescriptions = [
  {'id': 'coconut', 'description': 'Soft and sweet'},
];

const seedChallenges = {
  'challenges': [
    {
      'id': 'coco-donuts',
      'title': 'Eat 4 Coco donuts',
      'current': 4,
      'target': 4,
      'rewardPoints': 100,
      'progressStyle': 'donut',
      'imageUrl': 'assets/seed/images/rewards_donut.png',
    },
  ],
};

class SeedBundle extends AssetBundle {
  String _seedFor(String key) => jsonEncode(switch (key) {
    HomeLocalDataSource.descriptionsSeedAsset => seedDescriptions,
    RewardsLocalDataSource.seedAsset => seedChallenges,
    _ => seedFeed,
  });

  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(utf8.encode(_seedFor(key)));

  @override
  Future<String> loadString(String key, {bool cache = true}) async =>
      _seedFor(key);
}
