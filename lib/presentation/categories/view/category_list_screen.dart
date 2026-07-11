// lib/presentation/categories/view/category_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/categories/viewmodel/category_list_view_model.dart';

/// Screen that displays the list of categories.
class CategoryListScreen extends ConsumerStatefulWidget {
  const CategoryListScreen({super.key});

  @override
  ConsumerState<CategoryListScreen> createState() =>
      _CategoryListScreenState();
}

class _CategoryListScreenState extends ConsumerState<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger initial load of categories when the screen is first shown.
    Future.microtask(
          () => ref.read(categoryListViewModelProvider.notifier).loadCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: _buildBody(context, state),
      // FAB will be added later for add/edit/delete.
    );
  }

  /// Builds the main body of the screen, handling loading, error and empty states.
  Widget _buildBody(BuildContext context, CategoryListState state) {
    if (state.isLoading && state.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.categories.isEmpty) {
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

    if (state.categories.isEmpty) {
      return const Center(
        child: Text('No categories yet.'),
      );
    }

    return ListView.builder(
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return ListTile(
          title: Text(category.name),
          subtitle: category.description != null &&
              category.description!.trim().isNotEmpty
              ? Text(category.description!)
              : null,
        );
      },
    );
  }
}
