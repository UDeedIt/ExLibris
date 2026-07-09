// lib/presentation/books/viewmodel/book_list_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/data/providers/data_providers.dart';
import 'package:ex_libris/domain/entities/book.dart';
import 'package:ex_libris/data/repositories/book_repository.dart';
import 'package:ex_libris/domain/sample_data/sample_books.dart';

/// Immutable state for the book list screen.
class BookListState {
  /// Whether the data is currently being loaded.
  final bool isLoading;

  /// List of all books to be displayed.
  final List<Book> books;

  /// Optional error message to display in the UI.
  final String? errorMessage;

  const BookListState({
    required this.isLoading,
    required this.books,
    this.errorMessage,
  });

  /// Convenience constructor for the initial state.
  factory BookListState.initial() => const BookListState(
    isLoading: false,
    books: [],
    errorMessage: null,
  );

  /// Returns a copy of this state with the given fields updated.
  BookListState copyWith({
    bool? isLoading,
    List<Book>? books,
    String? errorMessage,
  }) {
    return BookListState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      errorMessage: errorMessage,
    );
  }
}

/// ViewModel responsible for loading and refreshing the list of books.
class BookListViewModel extends Notifier<BookListState> {
  @override
  BookListState build() => BookListState.initial();

  /// Loads all books using the [BookRepository] provider.
  /// or insert sample books if the list is empty
  Future<void> loadBooks() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(bookRepositoryProvider);
      var books = await repo.getAllBooks();

      // If there are no books yet, insert a few sample entries.
      if (books.isEmpty) {
        await _ensureSampleBooksIfEmpty(repo);
        books = await repo.getAllBooks();
      }

      state = state.copyWith(isLoading: false, books: books);

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Creates a new book using the [BookRepository] and refreshes the list.
  Future<void> addBook(Book book) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(bookRepositoryProvider);
      await repo.addBook(book);
      final books = await repo.getAllBooks();
      state = state.copyWith(isLoading: false, books: books);

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Updates an existing book and refreshes the list.
  Future<void> updateBook(Book book) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(bookRepositoryProvider);
      await repo.updateBook(book);
      final books = await repo.getAllBooks();
      state = state.copyWith(isLoading: false, books: books);

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }


  /// Deletes a book by its identifier and refreshes the list.
  Future<void> deleteBook(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(bookRepositoryProvider);
      await repo.deleteBook(id);
      final books = await repo.getAllBooks();
      state = state.copyWith(isLoading: false, books: books);

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }


  /// Inserts sample books into the repository if no books exist yet.
  ///
  /// This is used to populate the local database with initial data for
  /// demonstration purposes when the app is started on a clean install.
  Future<void> _ensureSampleBooksIfEmpty(BookRepository repo) async {
    final existing = await repo.getAllBooks();
    if (existing.isNotEmpty) return;

    for (final book in kSampleBooks) {
      await repo.addBook(book);
    }
  }
}

/// Riverpod provider exposing the [BookListViewModel] and its state.
final bookListViewModelProvider =
NotifierProvider<BookListViewModel, BookListState>(BookListViewModel.new);
