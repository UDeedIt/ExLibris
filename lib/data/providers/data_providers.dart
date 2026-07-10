// lib/data/data_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/data/repositories/book_repository.dart';
import 'package:ex_libris/data/repositories/author_repository.dart';

/// Provides a singleton [AppDatabase] instance for the whole application.
///
/// The database will be created lazily on first use and disposed
/// automatically when the provider is destroyed (typically on app shutdown).
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Provides the [BookRepository] used across the app.
///
/// This implementation is currently backed by Drift via [AppDatabase].
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftBookRepository(db);
});

/// Provides the [AuthorRepository] used across the app.
///
/// This implementation is currently backed by Drift via [AppDatabase].
final authorRepositoryProvider = Provider<AuthorRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftAuthorRepository(db);
});
