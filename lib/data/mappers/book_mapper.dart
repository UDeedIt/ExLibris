// lib/data/mappers/book_mapper.dart

import 'dart:convert';

import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/domain/entities/book.dart';

/// Utility for mapping between Drift [BookEntry] rows and domain [Book] entity.
class BookMapper {
  /// Converts a [BookEntry] (Drift row) into a domain [Book].
  ///
  /// [authorName] is taken from the joined Authors table, if available.
  static Book fromEntry(
      BookEntry entry, {
        String? authorName,
      }) {
    // The categories field is stored as a JSON-encoded list of strings.
    final raw = entry.categories;
    final List<String> categories;
    if (raw == null || raw.isEmpty) {
      categories = const [];
    } else {
      final decoded = jsonDecode(raw);
      categories = (decoded as List).map((e) => e.toString()).toList();
    }

    return Book(
      id: entry.id,
      title: entry.title,
      authorName: authorName,
      isbn: entry.isbn,
      readingStatus: entry.readingStatus,
      categories: categories,
    );
  }
}
