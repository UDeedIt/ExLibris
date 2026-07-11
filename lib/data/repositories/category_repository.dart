// lib/data/repositories/category_repository.dart

import 'package:drift/drift.dart' as drift show Value;
import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/domain/entities/category.dart';

import '../mappers/category_mapper.dart';

/// Abstraction for accessing and modifying category data.
///
/// Implementations can use local storage (Drift), remote APIs, or a combination.
abstract class CategoryRepository {
  /// Returns all categories stored locally.
  Future<List<Category>> getAllCategories();

  /// Persists a new category and returns the created instance, potentially with an assigned ID.
  Future<Category> addCategory(Category category);

  /// Updates an existing category.
  Future<void> updateCategory(Category category);

  /// Deletes a category by its identifier.
  Future<void> deleteCategory(int id);
}

/// Drift-based implementation of [CategoryRepository] using [AppDatabase].
class DriftCategoryRepository implements CategoryRepository {
  DriftCategoryRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<Category>> getAllCategories() async {
    final rows = await _db.select(_db.categories).get();
    return rows.map(CategoryMapper.fromEntry).toList();
  }


  @override
  Future<Category> addCategory(Category category) async {
    final id = await _db.into(_db.categories).insert(
      CategoriesCompanion.insert(
        name: category.name,
        description: drift.Value(category.description),
      ),
    );

    return Category(
      id: id,
      name: category.name,
      description: category.description,
    );
  }

  @override
  Future<void> updateCategory(Category category) async {
    final entry = CategoryMapper.toEntry(category);
    await _db.update(_db.categories).replace(entry);
  }


  @override
  Future<void> deleteCategory(int id) async {
    await (_db.delete(_db.categories)..where((t) => t.id.equals(id))).go();
  }
}
