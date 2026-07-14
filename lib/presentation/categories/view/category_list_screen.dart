// lib/presentation/categories/view/category_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/categories/viewmodel/category_list_view_model.dart';
import 'package:ex_libris/presentation/categories/view/add_category_screen.dart';
import 'package:ex_libris/presentation/categories/view/edit_category_screen.dart';

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
      body: _buildBody(context, ref, state),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddCategoryScreen(),
            ),
          );
          await ref
              .read(categoryListViewModelProvider.notifier)
              .loadCategories();
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  /// Builds the main body of the screen, handling loading, error and empty states.
  Widget _buildBody(BuildContext context, WidgetRef ref, CategoryListState state,) {
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
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => EditCategoryScreen(category: category),
              ),
            );
            await ref
                .read(categoryListViewModelProvider.notifier)
                .loadCategories();
          },
          title: Text(category.name),
          subtitle: category.description != null &&
              category.description!.trim().isNotEmpty
              ? Text(category.description!)
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Delete category'),
                    content: Text(
                      'Are you sure you want to delete "${category.name}"?',
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
                    .read(categoryListViewModelProvider.notifier)
                    .deleteCategory(category.id);
              }
            },
          ),
        );
      },
    );

  }
}
