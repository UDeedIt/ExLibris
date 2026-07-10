// lib/presentation/authors/viewmodel/author_list_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/data/providers/data_providers.dart';
import 'package:ex_libris/data/repositories/author_repository.dart';
import 'package:ex_libris/domain/entities/author.dart';

/// Immutable state for the author list screen.
class AuthorListState {
  /// Whether the data is currently being loaded.
  final bool isLoading;

  /// List of all authors to be displayed.
  final List<Author> authors;

  /// Optional error message to display in the UI.
  final String? errorMessage;

  const AuthorListState({
    required this.isLoading,
    required this.authors,
    this.errorMessage,
  });

  /// Convenience constructor for the initial state.
  factory AuthorListState.initial() => const AuthorListState(
    isLoading: false,
    authors: [],
    errorMessage: null,
  );

  /// Returns a copy of this state with the given fields updated.
  AuthorListState copyWith({
    bool? isLoading,
    List<Author>? authors,
    String? errorMessage,
  }) {
    return AuthorListState(
      isLoading: isLoading ?? this.isLoading,
      authors: authors ?? this.authors,
      errorMessage: errorMessage,
    );
  }
}

/// ViewModel responsible for loading and modifying the list of authors.
class AuthorListViewModel extends Notifier<AuthorListState> {
  @override
  AuthorListState build() => AuthorListState.initial();

  /// Loads all authors using the [AuthorRepository] provider.
  Future<void> loadAuthors() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(authorRepositoryProvider);
      final authors = await repo.getAllAuthors();
      state = state.copyWith(isLoading: false, authors: authors);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Creates a new author and refreshes the list.
  Future<void> addAuthor(Author author) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(authorRepositoryProvider);
      await repo.addAuthor(author);
      final authors = await repo.getAllAuthors();
      state = state.copyWith(isLoading: false, authors: authors);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Updates an existing author and refreshes the list.
  Future<void> updateAuthor(Author author) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(authorRepositoryProvider);
      await repo.updateAuthor(author);
      final authors = await repo.getAllAuthors();
      state = state.copyWith(isLoading: false, authors: authors);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Deletes an author by its identifier and refreshes the list.
  Future<void> deleteAuthor(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(authorRepositoryProvider);
      await repo.deleteAuthor(id);
      final authors = await repo.getAllAuthors();
      state = state.copyWith(isLoading: false, authors: authors);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

/// Riverpod provider exposing the [AuthorListViewModel] and its state.
final authorListViewModelProvider =
NotifierProvider<AuthorListViewModel, AuthorListState>(
  AuthorListViewModel.new,
);
