// lib/data/remote/backup_service.dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ex_libris/data/providers/data_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/backups/library_snapshot.dart';

/// Service responsible for backing up the current library state
/// to the external Ktor backend.
///
/// It builds a [LibrarySnapshot] from the local repositories and
/// sends it as JSON to the `/backup` endpoint.
class BackupService {
  BackupService(this._ref, {required this.baseUrl});

  /// Riverpod reference used to read repositories.
  final Ref _ref;

  /// Base URL of the Ktor server, for example `http://localhost:8080`.
  final String baseUrl;

  /// Builds a snapshot of the current library and sends it to the server.
  ///
  /// Throws an [Exception] if the server responds with a non-200 status code.
  Future<void> backup() async {
    // Build a complete snapshot from local repositories.
    final snapshot = await _buildSnapshot();

    // Compose the backup endpoint URL.
    final uri = Uri.parse('$baseUrl/backup');

    // Send the snapshot as JSON to the server.
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(snapshot.toJson()),
    );

    // Basic status check. For a demo this is sufficient.
    if (response.statusCode != 200) {
      throw Exception(
        'Backup failed: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Collects all books, authors and categories from the local repositories
  /// and converts them into a [LibrarySnapshot].
  Future<LibrarySnapshot> _buildSnapshot() async {
    // Read repositories via Riverpod providers.
    final bookRepo = _ref.read(bookRepositoryProvider);
    final authorRepo = _ref.read(authorRepositoryProvider);
    final categoryRepo = _ref.read(categoryRepositoryProvider);

    // Load domain entities from the local database.
    final authors = await authorRepo.getAllAuthors();
    final categories = await categoryRepo.getAllCategories();
    final books = await bookRepo.getAllBooks();

    // Map domain entities to snapshot DTOs.
    return LibrarySnapshot(
      authors: authors
          .map(
            (a) => AuthorSnapshot(
          name: a.name,
          bio: a.bio,
        ),
      )
          .toList(),
      categories: categories
          .map(
            (c) => CategorySnapshot(
          name: c.name,
          description: c.description,
        ),
      )
          .toList(),
      books: books
          .map(
            (b) => BookSnapshot(
          title: b.title,
          authorName: b.authorName,
          isbn: b.isbn,
          readingStatus: b.readingStatus,
          categories: b.categories,
        ),
      )
          .toList(),
    );
  }
}

/// Riverpod provider that exposes a [BackupService] instance.
///
/// The [baseUrl] is currently set for local development with the
/// Ktor server running on `localhost:8080`.
final backupServiceProvider = Provider<BackupService>((ref) {
  const baseUrl = 'http://localhost:8080';
  return BackupService(ref, baseUrl: baseUrl);
});
