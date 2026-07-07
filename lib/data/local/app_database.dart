// lib/data/local/app_database.dart

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// Importing the necessary tables
import 'books_table.dart';         // Book table definition
import 'authors_table.dart';       // Authors table definition
import 'categories_table.dart';     // Categories table definition

part 'app_database.g.dart';

/// A lazy database connection to the Drift SQLite database.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file); // Create a native database using sqflite
  });
}

/// The main database class for the Ex Libris app.
/// This class handles all CRUD operations for the books, authors, and categories.
@DriftDatabase(tables: [Books, Authors, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- DAO (Data Access Object) Methods for Books ---

  /// Retrieves all book entries from the database.
  Future<List<BookEntry>> getAllBooks() => select(books).get();

  /// Inserts a new book into the database.
  /// Returns the ID of the newly inserted row.
  Future<int> insertBook(BooksCompanion entry) => into(books).insert(entry);

  /// Updates an existing book entry in the database.
  /// Returns `true` if a row was updated, `false` otherwise.
  Future<bool> updateBook(BookEntry entry) => update(books).replace(entry);

  /// Deletes a specific book entry from the database by its ID.
  /// Returns the number of rows affected (should be 1 if found).
  Future<int> deleteBook(int id) => (delete(books)..where((t) => t.id.equals(id))).go();

  // --- DAO Methods for Authors ---

  /// Retrieves all authors from the database.
  Future<List<AuthorEntry>> getAllAuthors() => select(authors).get();

  /// Inserts a new author into the database.
  /// Returns the ID of the newly inserted author.
  Future<int> insertAuthor(AuthorsCompanion entry) => into(authors).insert(entry);

  /// Updates an existing author in the database.
  /// Returns `true` if a row was updated, `false` otherwise.
  Future<bool> updateAuthor(AuthorEntry entry) => update(authors).replace(entry);

  /// Deletes a specific author entry from the database by its ID.
  /// Returns the number of rows affected (should be 1 if found).
  Future<int> deleteAuthor(int id) => (delete(authors)..where((t) => t.id.equals(id))).go();

  // --- DAO Methods for Categories ---

  /// Retrieves all categories from the database.
  Future<List<CategoryEntry>> getAllCategories() => select(categories).get();

  /// Inserts a new category into the database.
  /// Returns the ID of the newly inserted category.
  Future<int> insertCategory(CategoriesCompanion entry) => into(categories).insert(entry);

  /// Updates an existing category in the database.
  /// Returns `true` if a row was updated, `false` otherwise.
  Future<bool> updateCategory(CategoryEntry entry) => update(categories).replace(entry);

  /// Deletes a specific category from the database by its ID.
  /// Returns the number of rows affected (should be 1 if found).
  Future<int> deleteCategory(int id) => (delete(categories)..where((t) => t.id.equals(id))).go();
}
