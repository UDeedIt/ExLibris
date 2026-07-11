// lib/data/mappers/category_mapper.dart

import 'package:ex_libris/data/local/app_database.dart';
import 'package:ex_libris/domain/entities/category.dart';

/// Maps between Drift [CategoryEntry] rows and the domain [Category] entity.
class CategoryMapper {
  /// Converts a [CategoryEntry] (Drift row) into a domain [Category].
  static Category fromEntry(CategoryEntry entry) {
    return Category(
      id: entry.id,
      name: entry.name,
      description: entry.description,
    );
  }

  /// Converts a domain [Category] into a [CategoryEntry] suitable for updates.
  ///
  /// For inserts, [CategoriesCompanion.insert] is typically preferred.
  static CategoryEntry toEntry(Category category) {
    return CategoryEntry(
      id: category.id,
      name: category.name,
      description: category.description,
    );
  }
}
