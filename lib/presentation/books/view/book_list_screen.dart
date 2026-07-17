// lib/presentation/books/view/book_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/books/viewmodel/book_list_view_model.dart';
import 'package:ex_libris/presentation/books/view/add_book_screen.dart';
import 'package:ex_libris/presentation/books/view/edit_book_screen.dart';

import '../../../data/remote/backup_service.dart';

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
    // Read the current state from the ViewModel using ref.
    final state = ref.watch(bookListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ex Libris'),
        actions: [
          // Backup button in the Books app bar.
          IconButton(
            icon: const Icon(Icons.cloud_upload_outlined),
            tooltip: 'Backup to server',
            onPressed: _onBackupPressed,
          ),
        ],
      ),
      body: _buildBody(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the AddBookScreen and refresh after returning.
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddBookScreen(),
            ),
          );
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
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        // Pick a color for the reading status chip.
        final Color statusColor;
        switch (book.readingStatus) {
          case 'reading':
            statusColor = colorScheme.tertiary;
            break;
          case 'finished':
            statusColor = colorScheme.secondary;
            break;
          case 'to_read':
          default:
            statusColor = colorScheme.primary;
            break;
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => EditBookScreen(book: book),
                ),
              );
              await ref
                  .read(bookListViewModelProvider.notifier)
                  .loadBooks();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Main text column (title + author).
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.authorName?.isNotEmpty == true
                              ? book.authorName!
                              : 'Unknown author',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color
                                ?.withValues(alpha: 0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Status chip + delete button.
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        label: Text(
                          _readingStatusLabel(book.readingStatus),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        backgroundColor: statusColor,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  /// Returns a human-readable label for a reading status code.
  String _readingStatusLabel(String status) {
    switch (status) {
      case 'to_read':
        return 'To read';

      case 'reading':
        return 'Reading';

      case 'finished':
        return 'Finished';

      default:
        return status;
    }
  }

  /// Triggers a backup of the current library state via [BackupService].
  ///
  /// Shows a [SnackBar] indicating success or failure.
  Future<void> _onBackupPressed() async {
    final messenger = ScaffoldMessenger.of(context);
    final backupService = ref.read(backupServiceProvider);

    try {
      await backupService.backup();
      messenger.showSnackBar(
        const SnackBar(content: Text('Backup successful')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Backup failed')),
      );
    }
  }

}
