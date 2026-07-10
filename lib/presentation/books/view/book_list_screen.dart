// lib/presentation/books/view/book_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/books/viewmodel/book_list_view_model.dart';
import 'package:ex_libris/presentation/books/view/add_book_screen.dart';
import 'package:ex_libris/presentation/books/view/edit_book_screen.dart';

/// Screen that displays the list of books.
///
/// Uses [bookListViewModelProvider] to load and observe state.
class BookListScreen extends ConsumerStatefulWidget {
  const BookListScreen({super.key});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}


class _BookListScreenState extends ConsumerState<BookListScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger initial load of books when the screen is first shown.
    Future.microtask(
          () => ref.read(bookListViewModelProvider.notifier).loadBooks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ex Libris'),
      ),
      body: _buildBody(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddBookScreen(),
            ),
          );
          // After returning from AddBookScreen, refresh the list.
          await ref.read(bookListViewModelProvider.notifier).loadBooks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Builds the main body of the screen.
  ///
  /// Wraps all content in a [RefreshIndicator] so that pull-to-refresh
  /// is consistently available.
  Widget _buildBody(
      BuildContext context,
      WidgetRef ref,
      BookListState state,
      ) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(bookListViewModelProvider.notifier).loadBooks(),
      child: _buildScrollableContent(context, ref, state),
    );
  }

  /// Builds the scrollable content used inside [RefreshIndicator].
  ///
  /// [AlwaysScrollableScrollPhysics] ensures that the pull-to-refresh gesture
  /// works even when the list is short or empty.
  Widget _buildScrollableContent(
      BuildContext context,
      WidgetRef ref,
      BookListState state,
      ) {
    if (state.isLoading && state.books.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    }

    if (state.errorMessage != null && state.books.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            state.errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    if (state.books.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 200,
            child: Center(
              child: Text('No books yet. Pull down to load or tap + to add.'),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.books.length,
      itemBuilder: (context, index) {
        final book = state.books[index];

        return ListTile(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => EditBookScreen(book: book),
              ),
            );
            // After returning from the edit screen, refresh the list.
            await ref.read(bookListViewModelProvider.notifier).loadBooks();
          },
          title: Text(book.title),
          subtitle: Text(
            book.authorName?.isNotEmpty == true
                ? book.authorName!
                : 'Unknown author',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(book.readingStatus),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete',
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Delete book'),
                        content: Text(
                          'Are you sure you want to delete "${book.title}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed == true) {
                    await ref
                        .read(bookListViewModelProvider.notifier)
                        .deleteBook(book.id);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
