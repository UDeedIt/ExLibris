// lib/data/local/categories_table.dart

import 'package:drift/drift.dart';

/// Represents the 'Categories' table in the Drift database.
/// This table is used to categorize books into genres or themes.
@DataClassName('CategoryEntry')
class Categories extends Table {
  /// Unique identifier for the category.
  IntColumn get id => integer().autoIncrement()();

  /// The name of the category.
  TextColumn get name => text().withLength(min: 1, max: 255)(); // Name of the genre/category
}
