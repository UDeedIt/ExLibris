// lib/domain/backup/library_snapshot.dart

/// Snapshot of the entire library used for backup/restore.
///
/// This mirrors the Ktor server's LibrarySnapshot / AuthorSnapshot /
/// CategorySnapshot / BookSnapshot structures.
class LibrarySnapshot {

  final List<AuthorSnapshot> authors;
  final List<CategorySnapshot> categories;
  final List<BookSnapshot> books;

  const LibrarySnapshot({
    required this.authors,
    required this.categories,
    required this.books,
  });

  factory LibrarySnapshot.empty() => const LibrarySnapshot(
    authors: [],
    categories: [],
    books: [],
  );

  factory LibrarySnapshot.fromJson(Map<String, dynamic> json) {
    return LibrarySnapshot(
      authors: (json['authors'] as List<dynamic>? ?? [])
          .map((e) => AuthorSnapshot.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => CategorySnapshot.fromJson(e as Map<String, dynamic>))
          .toList(),
      books: (json['books'] as List<dynamic>? ?? [])
          .map((e) => BookSnapshot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'authors': authors.map((a) => a.toJson()).toList(),
    'categories': categories.map((c) => c.toJson()).toList(),
    'books': books.map((b) => b.toJson()).toList(),
  };
}

/// Minimal author representation for backup.
class AuthorSnapshot {
  final String name;
  final String? bio;

  const AuthorSnapshot({
    required this.name,
    this.bio,
  });

  factory AuthorSnapshot.fromJson(Map<String, dynamic> json) {
    return AuthorSnapshot(
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    if (bio != null) 'bio': bio,
  };
}

/// Minimal category representation for backup.
class CategorySnapshot {
  final String name;
  final String? description;

  const CategorySnapshot({
    required this.name,
    this.description,
  });

  factory CategorySnapshot.fromJson(Map<String, dynamic> json) {
    return CategorySnapshot(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    if (description != null) 'description': description,
  };
}

/// Minimal book representation for backup.
///
/// References authors and categories by name.
class BookSnapshot {
  final String title;
  final String? authorName;
  final String? isbn;
  final String readingStatus;
  final List<String> categories;

  const BookSnapshot({
    required this.title,
    required this.readingStatus,
    this.authorName,
    this.isbn,
    this.categories = const [],
  });

  factory BookSnapshot.fromJson(Map<String, dynamic> json) {
    return BookSnapshot(
      title: json['title'] as String? ?? '',
      authorName: json['authorName'] as String?,
      isbn: json['isbn'] as String?,
      readingStatus: json['readingStatus'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    if (authorName != null) 'authorName': authorName,
    if (isbn != null) 'isbn': isbn,
    'readingStatus': readingStatus,
    'categories': categories,
  };
}
