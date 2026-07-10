// lib/presentation/authors/view/author_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/authors/viewmodel/author_list_view_model.dart';
import 'package:ex_libris/presentation/authors/view/add_author_screen.dart';
import 'package:ex_libris/presentation/authors/view/edit_author_screen.dart';

/// Screen that displays the list of authors.
class AuthorListScreen extends ConsumerStatefulWidget {
  const AuthorListScreen({super.key});

  @override
  ConsumerState<AuthorListScreen> createState() => _AuthorListScreenState();
}

class _AuthorListScreenState extends ConsumerState<AuthorListScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger initial load of authors when the screen is first shown.
    Future.microtask(
          () => ref.read(authorListViewModelProvider.notifier).loadAuthors(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authorListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
      ),
      body: _buildBody(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddAuthorScreen(),
            ),
          );
          await ref.read(authorListViewModelProvider.notifier).loadAuthors();
        },
        child: const Icon(Icons.add),
      ),
    );

  }

  /// Builds the main body of the screen, handling loading, error and empty states.
  /// Builds the main body of the screen, handling loading, error and empty states.
  Widget _buildBody(
      BuildContext context,
      WidgetRef ref,
      AuthorListState state,
      ) {
    if (state.isLoading && state.authors.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.authors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
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

    if (state.authors.isEmpty) {
      return const Center(
        child: Text('No authors yet.'),
      );
    }

    // Display the list of authors with edit and delete actions.
    return ListView.builder(
      itemCount: state.authors.length,
      itemBuilder: (context, index) {
        // Author for this row.
        final author = state.authors[index];

        return ListTile(
          onTap: () async {
            // Open the edit screen for this author.
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => EditAuthorScreen(author: author),
              ),
            );
            // Refresh the list after editing.
            await ref
                .read(authorListViewModelProvider.notifier)
                .loadAuthors();
          },
          title: Text(author.name),
          subtitle: author.bio != null && author.bio!.trim().isNotEmpty
              ? Text(author.bio!)
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Delete author'),
                    content: Text(
                      'Are you sure you want to delete "${author.name}"?',
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
                    .read(authorListViewModelProvider.notifier)
                    .deleteAuthor(author.id);
              }
            },
          ),
        );
      },
    );
  }

}
