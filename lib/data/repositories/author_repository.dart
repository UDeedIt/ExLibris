// lib/data/repositories/author_repository.dart

import 'package:drift/drift.dart' as drift show Value;
import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/domain/entities/author.dart';


/// Abstraction for accessing and modifying author data.
///
/// Implementations can use local storage (Drift), remote APIs, or a combination.
abstract class AuthorRepository {
  /// Returns all authors stored locally.
  Future<List<Author>> getAllAuthors();

  /// Persists a new author and returns the created instance, potentially with an assigned ID.
  Future<Author> addAuthor(Author author);

  /// Updates an existing author.
  Future<void> updateAuthor(Author author);

  /// Deletes an author by its identifier.
  Future<void> deleteAuthor(int id);
}


/// Drift-based implementation of [AuthorRepository] using [AppDatabase].
class DriftAuthorRepository implements AuthorRepository {
  DriftAuthorRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<Author>> getAllAuthors() async {
    final rows = await _db.select(_db.authors).get();
    return rows
        .map(
          (entry) => Author(
        id: entry.id,
        name: entry.name,
        bio: entry.bio,
      ),
    )
        .toList();
  }

  @override
  Future<Author> addAuthor(Author author) async {
    final id = await _db.into(_db.authors).insert(
      AuthorsCompanion.insert(
        name: author.name,
        bio: drift.Value(author.bio),
      ),
    );

    return Author(
      id: id,
      name: author.name,
      bio: author.bio,
    );
  }

  @override
  Future<void> updateAuthor(Author author) async {
    final entry = AuthorEntry(
      id: author.id,
      name: author.name,
      bio: author.bio,
    );

    await _db.update(_db.authors).replace(entry);
  }

  @override
  Future<void> deleteAuthor(int id) async {
    await (_db.delete(_db.authors)..where((t) => t.id.equals(id))).go();
  }
}
