import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';
import 'package:jdonuts/src/features/home/data/data.dart';
import 'package:jdonuts/src/features/home/domain/domain.dart';

@lazySingleton
class HomeLocalDataSource {
  final AppDatabase _db;
  final AssetBundle _bundle;

  const HomeLocalDataSource(this._db, this._bundle);

  static const seedAsset = 'assets/seed/home.json';

  Future<void> seedIfEmpty() async {
    final firstSection = await (_db.select(_db.menuSections)..limit(1))
        .getSingleOrNull();
    if (firstSection != null) return;

    final seed = jsonDecode(await _bundle.loadString(seedAsset));
    await replaceFeed(HomeFeedModel.fromJson(seed as Map<String, dynamic>));
  }

  Future<void> replaceFeed(HomeFeedModel feed) {
    return _db.transaction(() async {
      await _db.delete(_db.sectionItems).go();
      await _db.delete(_db.menuSections).go();
      await _db.delete(_db.menuItems).go();
      await _db.delete(_db.shops).go();
      await _db.batch((batch) {
        batch.insertAll(_db.shops, [
          for (final (position, shop) in feed.shops.indexed)
            _shopRow(shop, position),
        ]);
        batch.insertAll(_db.menuSections, [
          for (final (position, section) in feed.menuSections.indexed)
            _sectionRow(section, position),
        ]);
        for (final section in feed.menuSections) {
          batch.insertAllOnConflictUpdate(_db.menuItems, [
            for (final item in section.items) _itemRow(item),
          ]);
          batch.insertAllOnConflictUpdate(_db.sectionItems, [
            for (final (position, item) in section.items.indexed)
              _sectionItemRow(section.id, item, position),
          ]);
        }
      });
    });
  }

  Stream<HomeFeed> watchFeed() async* {
    yield await _loadFeed();
    yield* _db
        .tableUpdates(
          TableUpdateQuery.onAllTables([
            _db.shops,
            _db.menuSections,
            _db.menuItems,
            _db.sectionItems,
          ]),
        )
        .asyncMap((_) => _loadFeed());
  }

  Future<HomeFeed> _loadFeed() async {
    final shops = await (_db.select(_db.shops)
          ..orderBy([(shop) => OrderingTerm.asc(shop.position)]))
        .get();
    final sections = await (_db.select(_db.menuSections)
          ..orderBy([(section) => OrderingTerm.asc(section.position)]))
        .get();
    final sectionItems = await (_db.select(_db.sectionItems).join([
      innerJoin(
        _db.menuItems,
        _db.menuItems.id.equalsExp(_db.sectionItems.itemId),
      ),
    ])..orderBy([OrderingTerm.asc(_db.sectionItems.position)])).get();

    return HomeFeed(
      shops: shops.map(_shop).toList(),
      menuSections: [
        for (final section in sections)
          MenuSection(
            id: section.id,
            title: section.title,
            itemAspectRatio: section.itemAspectRatio,
            items: [
              for (final row in sectionItems)
                if (row.readTable(_db.sectionItems).sectionId == section.id)
                  _menuItem(
                    row.readTable(_db.menuItems),
                    row.readTable(_db.sectionItems),
                  ),
            ],
          ),
      ],
    );
  }

  ShopsCompanion _shopRow(ShopModel shop, int position) => ShopsCompanion.insert(
    id: shop.id,
    position: position,
    name: shop.name,
    title: Value(shop.title),
    address: shop.address,
    imageUrl: Value(shop.imageUrl),
    imageAspectRatio: Value(shop.imageAspectRatio),
    promotionLabel: Value(shop.promotion?.label),
    promotionPosition: Value(shop.promotion?.position),
    promotionKind: Value(shop.promotion?.kind),
  );

  MenuSectionsCompanion _sectionRow(MenuSectionModel section, int position) =>
      MenuSectionsCompanion.insert(
        id: section.id,
        position: position,
        title: section.title,
        itemAspectRatio: section.itemAspectRatio,
      );

  MenuItemsCompanion _itemRow(MenuItemModel item) => MenuItemsCompanion.insert(
    id: item.id,
    code: item.code,
    name: item.name,
    priceMmk: item.priceMmk,
    isNew: item.isNew,
    imageUrl: item.imageUrl,
    imageAspectRatio: item.imageAspectRatio,
  );

  SectionItemsCompanion _sectionItemRow(
    String sectionId,
    MenuItemModel item,
    int position,
  ) => SectionItemsCompanion.insert(
    sectionId: sectionId,
    itemId: item.id,
    position: position,
    promotionLabel: Value(item.promotion?.label),
    promotionPosition: Value(item.promotion?.position),
    promotionKind: Value(item.promotion?.kind),
  );

  Shop _shop(ShopRow row) => Shop(
    id: row.id,
    name: row.name,
    title: row.title,
    address: row.address,
    imageUrl: row.imageUrl,
    imageAspectRatio: row.imageAspectRatio,
    promotion: _promotion(
      row.promotionLabel,
      row.promotionPosition,
      row.promotionKind,
    ),
  );

  MenuItem _menuItem(MenuItemRow item, SectionItemRow placement) => MenuItem(
    id: item.id,
    code: item.code,
    name: item.name,
    priceMmk: item.priceMmk,
    isNew: item.isNew,
    imageUrl: item.imageUrl,
    imageAspectRatio: item.imageAspectRatio,
    promotion: _promotion(
      placement.promotionLabel,
      placement.promotionPosition,
      placement.promotionKind,
    ),
  );

  Promotion? _promotion(String? label, String? position, String? kind) =>
      label == null
      ? null
      : PromotionModel(label: label, position: position, kind: kind)
            .toEntity();
}
