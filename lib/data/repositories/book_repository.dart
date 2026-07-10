// lib/data/repositories/book_repository.dart

import 'dart:convert';
import 'package:ex_libris/domain/entities/book.dart';
import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/data/mappers/book_mapper.dart';
import 'package:drift/drift.dart' as drift show Value, leftOuterJoin;

/// Abstraction for accessing and modifying book data.
///
/// Implementations can use local storage (Drift), remote APIs, or a combination.
abstract class BookRepository {
  /// Returns all books stored locally.
  Future<List<Book>> getAllBooks();

  /// Persists a new book and returns the created instance, potentially with an assigned ID.
  Future<Book> addBook(Book book);

  /// Updates an existing book.
  Future<void> updateBook(Book book);

  /// Deletes a book by its identifier.
  Future<void> deleteBook(int id);
}


/// Drift-based implementation of [BookRepository] using [AppDatabase].
class DriftBookRepository implements BookRepository {
  DriftBookRepository(this._db);

  final AppDatabase _db;

  // @override
  // Future<List<Book>> getAllBooks() async {
  //   final entries = await _db.getAllBooks();
  //   return entries.map(BookMapper.fromEntry).toList();
  // }

  @override
  Future<List<Book>> getAllBooks() async {
    // Join books with authors to obtain author names.
    final query = _db.select(_db.books).join([
      drift.leftOuterJoin(
        _db.authors,
        _db.authors.id.equalsExp(_db.books.authorId),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final bookEntry = row.readTable(_db.books);
      final authorEntry = row.readTableOrNull(_db.authors);
      return BookMapper.fromEntry(
        bookEntry,
        authorName: authorEntry?.name,
      );
    }).toList();
  }


  @override
  Future<Book> addBook(Book book) async {
    final authorId = await _resolveAuthorId(book.authorName);

    final id = await _db.insertBook(
      BooksCompanion.insert(
        title: book.title,
        authorId: drift.Value(authorId),
        isbn: drift.Value(book.isbn),
        categories: drift.Value(
          book.categories.isEmpty ? null : jsonEncode(book.categories),
        ),
        readingStatus: book.readingStatus,
      ),
    );

    // Return a copy with the generated id (authorName remains unchanged).
    return Book(
      id: id,
      title: book.title,
      authorName: book.authorName,
      isbn: book.isbn,
      readingStatus: book.readingStatus,
      categories: book.categories,
    );
  }


  @override
  Future<void> updateBook(Book book) async {
    final authorId = await _resolveAuthorId(book.authorName);

    final entry = BookEntry(
      id: book.id,
      title: book.title,
      authorId: authorId,
      isbn: book.isbn,
      categories:
      book.categories.isEmpty ? null : jsonEncode(book.categories),
      readingStatus: book.readingStatus,
    );

    await _db.updateBook(entry);
  }


  @override
  Future<void> deleteBook(int id) async {
    await _db.deleteBook(id);
  }

  /// Returns an author id for the given [authorName].
  ///
  /// If [authorName] is null or empty, returns null.
  /// If an author with the same name exists, its id is reused.
  /// Otherwise, a new author row is inserted and its id returned.
  Future<int?> _resolveAuthorId(String? authorName) async {
    final trimmed = authorName?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    // Try to find an existing author with the same name.
    final existingQuery = _db.select(_db.authors)
      ..where((a) => a.name.equals(trimmed));

    final existing = await existingQuery.getSingleOrNull();
    if (existing != null) {
      return existing.id;
    }

    // Insert a new author.
    final newId = await _db.into(_db.authors).insert(
      AuthorsCompanion.insert(name: trimmed),
    );
    return newId;
  }

}
