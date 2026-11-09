import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/src/features/commons/data/data.dart';

void main() {
  test(
    'upgrading from version 1 adds the product description column',
    () async {
      final db = AppDatabase(
        NativeDatabase.memory(
          setup: (raw) {
            raw.execute(
              'CREATE TABLE menu_items (id TEXT NOT NULL PRIMARY KEY, '
              'code TEXT NOT NULL, name TEXT NOT NULL, '
              'price_mmk INTEGER NOT NULL, is_new INTEGER NOT NULL, '
              'image_url TEXT NOT NULL, image_aspect_ratio REAL NOT NULL)',
            );
            raw.execute(
              "INSERT INTO menu_items VALUES "
              "('coconut', 'JD022123', 'Coconut Donut', 3200, 1, 'x.png', 1.0)",
            );
            raw.execute('PRAGMA user_version = 1');
          },
        ),
      );

      await (db.update(
        db.menuItems,
      )..where((item) => item.id.equals('coconut'))).write(
        const MenuItemsCompanion(description: Value('Soft and sweet')),
      );
      final row = await db.select(db.menuItems).getSingle();

      expect(row.description, 'Soft and sweet');
      await db.close();
    },
  );
}
