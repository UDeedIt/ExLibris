// lib/presentation/authors/view/author_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/authors/viewmodel/author_list_view_model.dart';

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
      body: _buildBody(context, state),
      // FAB for add author will be added later.
    );
  }

  /// Builds the main body of the screen, handling loading, error and empty states.
  Widget _buildBody(BuildContext context, AuthorListState state) {
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

    return ListView.builder(
      itemCount: state.authors.length,
      itemBuilder: (context, index) {
        final author = state.authors[index];
        return ListTile(
          title: Text(author.name),
          subtitle: author.bio != null && author.bio!.trim().isNotEmpty
              ? Text(author.bio!)
              : null,
        );
      },
    );
  }
}
