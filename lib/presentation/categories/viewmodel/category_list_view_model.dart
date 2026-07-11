// lib/presentation/categories/viewmodel/category_list_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/data/providers/data_providers.dart';
import 'package:ex_libris/data/repositories/category_repository.dart';
import 'package:ex_libris/domain/entities/category.dart';
import 'package:ex_libris/domain/sample_data/sample_categories.dart';


/// Immutable state for the category list screen.
class CategoryListState {

  /// Whether the data is currently being loaded.
  final bool isLoading;

  /// List of all categories to be displayed.
  final List<Category> categories;

  /// Optional error message to display in the UI.
  final String? errorMessage;

  const CategoryListState({
    required this.isLoading,
    required this.categories,
    this.errorMessage,
  });

  /// Convenience constructor for the initial state.
  factory CategoryListState.initial() => const CategoryListState(
    isLoading: false,
    categories: [],
    errorMessage: null,
  );

  /// Returns a copy of this state with the given fields updated.
  CategoryListState copyWith({
    bool? isLoading,
    List<Category>? categories,
    String? errorMessage,
  }) {
    return CategoryListState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
    );
  }
}


/// ViewModel responsible for loading and modifying the list of categories.
class CategoryListViewModel extends Notifier<CategoryListState> {
  @override
  CategoryListState build() => CategoryListState.initial();

  /// Loads all categories using the [CategoryRepository] provider.
  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(categoryRepositoryProvider);
      var categories = await repo.getAllCategories();

      // If there are no categories yet, insert a few sample entries.
      if (categories.isEmpty) {
        await _ensureSampleCategoriesIfEmpty(repo);
        categories = await repo.getAllCategories();
      }

      state = state.copyWith(isLoading: false, categories: categories);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Creates a new category and refreshes the list.
  Future<void> addCategory(Category category) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(categoryRepositoryProvider);
      await repo.addCategory(category);
      final categories = await repo.getAllCategories();
      state = state.copyWith(isLoading: false, categories: categories);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Updates an existing category and refreshes the list.
  Future<void> updateCategory(Category category) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(categoryRepositoryProvider);
      await repo.updateCategory(category);
      final categories = await repo.getAllCategories();
      state = state.copyWith(isLoading: false, categories: categories);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Deletes a category by its identifier and refreshes the list.
  Future<void> deleteCategory(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(categoryRepositoryProvider);
      await repo.deleteCategory(id);
      final categories = await repo.getAllCategories();
      state = state.copyWith(isLoading: false, categories: categories);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Inserts sample categories into the repository if no categories exist yet.
  ///
  /// This is used to populate the local database with initial data for
  /// demonstration purposes when the app is started on a clean install.
  Future<void> _ensureSampleCategoriesIfEmpty(CategoryRepository repo) async {
    final existing = await repo.getAllCategories();
    if (existing.isNotEmpty) return;

    for (final category in kSampleCategories) {
      await repo.addCategory(category);
    }
  }
}


/// Riverpod provider exposing the [CategoryListViewModel] and its state.
final categoryListViewModelProvider =
NotifierProvider<CategoryListViewModel, CategoryListState>(
  CategoryListViewModel.new,
);
