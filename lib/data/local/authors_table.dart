// lib/data/local/authors_table.dart

import 'package:drift/drift.dart';

/// Represents the 'Authors' table in the Drift database.
/// This table stores information about authors of the books.
@DataClassName('AuthorEntry')
class Authors extends Table {
  /// Unique identifier for the author.
  IntColumn get id => integer().autoIncrement()();

  /// The name of the author.
  TextColumn get name => text().withLength(min: 1, max: 255)();

  /// A brief biography or description of the author.
  /// Nullable, as not all authors may have a biography.
  TextColumn get bio => text().nullable()(); // Optional field for author's biography
}
