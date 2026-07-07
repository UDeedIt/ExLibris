// lib/domain/entities/book.dart

/// Domain-level representation of a book in Ex Libris.
///
/// This entity is independent of how data is stored (Drift, REST API, etc.).
/// UI and business logic should prefer using [Book] instead of database types.
class Book {
  /// Unique identifier of the book.
  final int id;

  /// Human-readable title of the book.
  final String title;

  /// Optional author name; may be null if not specified.
  final String? authorName;

  /// Optional ISBN of the book.
  final String? isbn;

  /// Reading status, e.g. "to_read", "reading", "finished".
  final String readingStatus;

  /// List of category names or IDs associated with this book.
  ///
  /// For the portfolio version this can be a simple list of strings
  /// mapped from a JSON-encoded field in the local database.
  final List<String> categories;

  const Book({
    required this.id,
    required this.title,
    required this.readingStatus,
    this.authorName,
    this.isbn,
    this.categories = const [],
  });
}
