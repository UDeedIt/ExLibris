// lib/domain/entities/category.dart

/// Domain-level representation of a category in Ex Libris.
///
/// This entity is independent of how data is stored (e.g. Drift, REST API).
class Category {
  /// Unique identifier of the category.
  final int id;

  /// Display name of the category.
  final String name;

  /// Optional descriptive text for the category.
  final String? description;

  const Category({
    required this.id,
    required this.name,
    this.description,
  });
}
