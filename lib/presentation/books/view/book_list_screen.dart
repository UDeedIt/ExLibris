// lib/presentation/books/view/book_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/books/viewmodel/book_list_view_model.dart';

/// Screen that displays the list of books.
///
/// Uses [bookListViewModelProvider] to load and observe state.
class BookListScreen extends ConsumerWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
      ),
      body: _buildBody(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger a manual refresh of the book list.
          ref.read(bookListViewModelProvider.notifier).loadBooks();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      WidgetRef ref,
      BookListState state,
      ) {
    if (state.isLoading && state.books.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.books.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            state.errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state.books.isEmpty) {
      return const Center(
        child: Text('No books yet. Tap the refresh button to load data.'),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(bookListViewModelProvider.notifier).loadBooks(),
      child: ListView.builder(
        itemCount: state.books.length,
        itemBuilder: (context, index) {
          final book = state.books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(
              book.authorName?.isNotEmpty == true
                  ? book.authorName!
                  : 'Unknown author',
            ),
            trailing: Text(book.readingStatus),
          );
        },
      ),
    );
  }
}
