// lib/data/mappers/author_mapper.dart

import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/domain/entities/author.dart';

/// Maps between Drift [AuthorEntry] rows and the domain [Author] entity.
class AuthorMapper {
  /// Converts a [AuthorEntry] (Drift row) into a domain [Author].
  static Author fromEntry(AuthorEntry entry) {
    return Author(
      id: entry.id,
      name: entry.name,
      bio: entry.bio,
    );
  }

  /// Converts a domain [Author] into a [AuthorEntry] suitable for updates.
  ///
  /// For inserts, prefer using [AuthorsCompanion.insert] directly.
  static AuthorEntry toEntry(Author author) {
    return AuthorEntry(
      id: author.id,
      name: author.name,
      bio: author.bio,
    );
  }
}
