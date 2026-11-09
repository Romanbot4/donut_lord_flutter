import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();
  TextColumn get tier => text()();
  IntColumn get totalPoints => integer()();
  IntColumn get pointsToNextTier => integer()();
  RealColumn get progressToNextTier => real()();
  IntColumn get unreadNotifications => integer()();
  IntColumn get availableRewards => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ShopRow')
class Shops extends Table {
  TextColumn get id => text()();
  IntColumn get position => integer()();
  TextColumn get name => text()();
  TextColumn get title => text().nullable()();
  TextColumn get address => text()();
  TextColumn get imageUrl => text().nullable()();
  RealColumn get imageAspectRatio => real().nullable()();
  TextColumn get promotionLabel => text().nullable()();
  TextColumn get promotionPosition => text().nullable()();
  TextColumn get promotionKind => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MenuSectionRow')
class MenuSections extends Table {
  TextColumn get id => text()();
  IntColumn get position => integer()();
  TextColumn get title => text()();
  RealColumn get itemAspectRatio => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MenuItemRow')
class MenuItems extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get priceMmk => integer()();
  BoolColumn get isNew => boolean()();
  TextColumn get imageUrl => text()();
  RealColumn get imageAspectRatio => real()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SectionItemRow')
class SectionItems extends Table {
  TextColumn get sectionId => text().references(MenuSections, #id)();
  TextColumn get itemId => text().references(MenuItems, #id)();
  IntColumn get position => integer()();
  TextColumn get promotionLabel => text().nullable()();
  TextColumn get promotionPosition => text().nullable()();
  TextColumn get promotionKind => text().nullable()();

  @override
  Set<Column> get primaryKey => {sectionId, itemId};
}

@DataClassName('ChallengeRow')
class Challenges extends Table {
  TextColumn get id => text()();
  IntColumn get position => integer()();
  TextColumn get title => text()();
  IntColumn get current => integer()();
  IntColumn get target => integer()();
  IntColumn get rewardPoints => integer()();
  TextColumn get progressStyle => text().nullable()();
  TextColumn get imageUrl => text()();
  RealColumn get imageAspectRatio => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [Members, Shops, MenuSections, MenuItems, SectionItems, Challenges],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) await migrator.addColumn(menuItems, menuItems.description);
      if (from < 3) await migrator.createTable(challenges);
    },
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
