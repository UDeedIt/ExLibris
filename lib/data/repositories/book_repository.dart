// lib/data/repositories/book_repository.dart

import 'dart:convert';
import 'package:ex_libris/domain/entities/book.dart';
import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/data/mappers/book_mapper.dart';
import 'package:drift/drift.dart' show Value;

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

  @override
  Future<List<Book>> getAllBooks() async {
    final entries = await _db.getAllBooks();
    return entries.map(BookMapper.fromEntry).toList();
  }

  @override
  Future<Book> addBook(Book book) async {
    final id = await _db.insertBook(
      BooksCompanion.insert(
        title: book.title,
        authorId: const Value(null), // Author handling can be added later.
        isbn: Value(book.isbn),
        categories: Value(
          book.categories.isEmpty ? null : jsonEncode(book.categories),
        ),
        readingStatus: book.readingStatus,
      ),
    );

    // Return a copy with the generated id.
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
    final entry = BookEntry(
      id: book.id,
      title: book.title,
      authorId: null, // To be wired with Authors later.
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
}
