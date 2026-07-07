// lib/data/local/books_table.dart

import 'package:drift/drift.dart';

/// Represents the 'Books' table in the Drift database.
/// This table stores information about books in the library.
@DataClassName('BookEntry')
class Books extends Table {
  /// Unique identifier for the book.
  IntColumn get id => integer().autoIncrement()();

  /// The title of the book.
  TextColumn get title => text().withLength(min: 1, max: 255)();

  /// Foreign key reference to the Author table.
  /// Nullable, as it’s possible to add a book without specifying an author.
  IntColumn get authorId => integer().nullable()();

  /// The International Standard Book Number (ISBN).
  /// Nullable, as some books may not have an ISBN.
  TextColumn get isbn => text().nullable()();

  /// A JSON string representing the list of category ids associated with this book.
  /// Example: ["Fiction", "Mystery"]
  TextColumn get categories => text().nullable()(); // Store categories as a JSON string.

  /// The reading status of the book.
  TextColumn get readingStatus => text().withLength(min: 1, max: 50)(); // Status of reading
}
