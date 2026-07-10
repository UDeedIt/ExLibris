// lib/domain/entities/author.dart

/// Domain-level representation of an author in Ex Libris.
///
/// This entity is independent of how data is stored (e.g. Drift, REST API).
class Author {
  /// Unique identifier of the author.
  final int id;

  /// Display name of the author.
  final String name;

  /// Optional biographical or descriptive text.
  final String? bio;

  const Author({
    required this.id,
    required this.name,
    this.bio,
  });
}
