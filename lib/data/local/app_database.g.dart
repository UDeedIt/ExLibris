// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, BookEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<int> authorId = GeneratedColumn<int>(
    'author_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
    'isbn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoriesMeta = const VerificationMeta(
    'categories',
  );
  @override
  late final GeneratedColumn<String> categories = GeneratedColumn<String>(
    'categories',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readingStatusMeta = const VerificationMeta(
    'readingStatus',
  );
  @override
  late final GeneratedColumn<String> readingStatus = GeneratedColumn<String>(
    'reading_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    authorId,
    isbn,
    categories,
    readingStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    }
    if (data.containsKey('isbn')) {
      context.handle(
        _isbnMeta,
        isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta),
      );
    }
    if (data.containsKey('categories')) {
      context.handle(
        _categoriesMeta,
        categories.isAcceptableOrUnknown(data['categories']!, _categoriesMeta),
      );
    }
    if (data.containsKey('reading_status')) {
      context.handle(
        _readingStatusMeta,
        readingStatus.isAcceptableOrUnknown(
          data['reading_status']!,
          _readingStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}author_id'],
      ),
      isbn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn'],
      ),
      categories: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categories'],
      ),
      readingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_status'],
      )!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class BookEntry extends DataClass implements Insertable<BookEntry> {
  /// Unique identifier for the book.
  final int id;

  /// The title of the book.
  final String title;

  /// Foreign key reference to the Author table.
  /// Nullable, as it’s possible to add a book without specifying an author.
  final int? authorId;

  /// The International Standard Book Number (ISBN).
  /// Nullable, as some books may not have an ISBN.
  final String? isbn;

  /// A JSON string representing the list of category ids associated with this book.
  /// Example: ["Fiction", "Mystery"]
  final String? categories;

  /// The reading status of the book.
  final String readingStatus;
  const BookEntry({
    required this.id,
    required this.title,
    this.authorId,
    this.isbn,
    this.categories,
    required this.readingStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<int>(authorId);
    }
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    if (!nullToAbsent || categories != null) {
      map['categories'] = Variable<String>(categories);
    }
    map['reading_status'] = Variable<String>(readingStatus);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      categories: categories == null && nullToAbsent
          ? const Value.absent()
          : Value(categories),
      readingStatus: Value(readingStatus),
    );
  }

  factory BookEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookEntry(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      authorId: serializer.fromJson<int?>(json['authorId']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      categories: serializer.fromJson<String?>(json['categories']),
      readingStatus: serializer.fromJson<String>(json['readingStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'authorId': serializer.toJson<int?>(authorId),
      'isbn': serializer.toJson<String?>(isbn),
      'categories': serializer.toJson<String?>(categories),
      'readingStatus': serializer.toJson<String>(readingStatus),
    };
  }

  BookEntry copyWith({
    int? id,
    String? title,
    Value<int?> authorId = const Value.absent(),
    Value<String?> isbn = const Value.absent(),
    Value<String?> categories = const Value.absent(),
    String? readingStatus,
  }) => BookEntry(
    id: id ?? this.id,
    title: title ?? this.title,
    authorId: authorId.present ? authorId.value : this.authorId,
    isbn: isbn.present ? isbn.value : this.isbn,
    categories: categories.present ? categories.value : this.categories,
    readingStatus: readingStatus ?? this.readingStatus,
  );
  BookEntry copyWithCompanion(BooksCompanion data) {
    return BookEntry(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      categories: data.categories.present
          ? data.categories.value
          : this.categories,
      readingStatus: data.readingStatus.present
          ? data.readingStatus.value
          : this.readingStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authorId: $authorId, ')
          ..write('isbn: $isbn, ')
          ..write('categories: $categories, ')
          ..write('readingStatus: $readingStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, authorId, isbn, categories, readingStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.authorId == this.authorId &&
          other.isbn == this.isbn &&
          other.categories == this.categories &&
          other.readingStatus == this.readingStatus);
}

class BooksCompanion extends UpdateCompanion<BookEntry> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> authorId;
  final Value<String?> isbn;
  final Value<String?> categories;
  final Value<String> readingStatus;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.authorId = const Value.absent(),
    this.isbn = const Value.absent(),
    this.categories = const Value.absent(),
    this.readingStatus = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.authorId = const Value.absent(),
    this.isbn = const Value.absent(),
    this.categories = const Value.absent(),
    required String readingStatus,
  }) : title = Value(title),
       readingStatus = Value(readingStatus);
  static Insertable<BookEntry> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? authorId,
    Expression<String>? isbn,
    Expression<String>? categories,
    Expression<String>? readingStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (authorId != null) 'author_id': authorId,
      if (isbn != null) 'isbn': isbn,
      if (categories != null) 'categories': categories,
      if (readingStatus != null) 'reading_status': readingStatus,
    });
  }

  BooksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int?>? authorId,
    Value<String?>? isbn,
    Value<String?>? categories,
    Value<String>? readingStatus,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      authorId: authorId ?? this.authorId,
      isbn: isbn ?? this.isbn,
      categories: categories ?? this.categories,
      readingStatus: readingStatus ?? this.readingStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<int>(authorId.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(categories.value);
    }
    if (readingStatus.present) {
      map['reading_status'] = Variable<String>(readingStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authorId: $authorId, ')
          ..write('isbn: $isbn, ')
          ..write('categories: $categories, ')
          ..write('readingStatus: $readingStatus')
          ..write(')'))
        .toString();
  }
}

class $AuthorsTable extends Authors with TableInfo<$AuthorsTable, AuthorEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, bio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'authors';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuthorEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthorEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthorEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
    );
  }

  @override
  $AuthorsTable createAlias(String alias) {
    return $AuthorsTable(attachedDatabase, alias);
  }
}

class AuthorEntry extends DataClass implements Insertable<AuthorEntry> {
  /// Unique identifier for the author.
  final int id;

  /// The name of the author.
  final String name;

  /// A brief biography or description of the author.
  /// Nullable, as not all authors may have a biography.
  final String? bio;
  const AuthorEntry({required this.id, required this.name, this.bio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    return map;
  }

  AuthorsCompanion toCompanion(bool nullToAbsent) {
    return AuthorsCompanion(
      id: Value(id),
      name: Value(name),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
    );
  }

  factory AuthorEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthorEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      bio: serializer.fromJson<String?>(json['bio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'bio': serializer.toJson<String?>(bio),
    };
  }

  AuthorEntry copyWith({
    int? id,
    String? name,
    Value<String?> bio = const Value.absent(),
  }) => AuthorEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    bio: bio.present ? bio.value : this.bio,
  );
  AuthorEntry copyWithCompanion(AuthorsCompanion data) {
    return AuthorEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      bio: data.bio.present ? data.bio.value : this.bio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthorEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('bio: $bio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, bio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthorEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.bio == this.bio);
}

class AuthorsCompanion extends UpdateCompanion<AuthorEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> bio;
  const AuthorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.bio = const Value.absent(),
  });
  AuthorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.bio = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AuthorEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? bio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (bio != null) 'bio': bio,
    });
  }

  AuthorsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? bio,
  }) {
    return AuthorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('bio: $bio')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryEntry extends DataClass implements Insertable<CategoryEntry> {
  /// Unique identifier for the category.
  final int id;

  /// The name of the category.
  final String name;
  const CategoryEntry({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(id: Value(id), name: Value(name));
  }

  factory CategoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  CategoryEntry copyWith({int? id, String? name}) =>
      CategoryEntry(id: id ?? this.id, name: name ?? this.name);
  CategoryEntry copyWithCompanion(CategoriesCompanion data) {
    return CategoryEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntry(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntry &&
          other.id == this.id &&
          other.name == this.name);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntry> {
  final Value<int> id;
  final Value<String> name;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<CategoryEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CategoriesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $AuthorsTable authors = $AuthorsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    books,
    authors,
    categories,
  ];
}

typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      required String title,
      Value<int?> authorId,
      Value<String?> isbn,
      Value<String?> categories,
      required String readingStatus,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int?> authorId,
      Value<String?> isbn,
      Value<String?> categories,
      Value<String> readingStatus,
    });

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingStatus => $composableBuilder(
    column: $table.readingStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingStatus => $composableBuilder(
    column: $table.readingStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get isbn =>
      $composableBuilder(column: $table.isbn, builder: (column) => column);

  GeneratedColumn<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingStatus => $composableBuilder(
    column: $table.readingStatus,
    builder: (column) => column,
  );
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          BookEntry,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (BookEntry, BaseReferences<_$AppDatabase, $BooksTable, BookEntry>),
          BookEntry,
          PrefetchHooks Function()
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> authorId = const Value.absent(),
                Value<String?> isbn = const Value.absent(),
                Value<String?> categories = const Value.absent(),
                Value<String> readingStatus = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                title: title,
                authorId: authorId,
                isbn: isbn,
                categories: categories,
                readingStatus: readingStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<int?> authorId = const Value.absent(),
                Value<String?> isbn = const Value.absent(),
                Value<String?> categories = const Value.absent(),
                required String readingStatus,
              }) => BooksCompanion.insert(
                id: id,
                title: title,
                authorId: authorId,
                isbn: isbn,
                categories: categories,
                readingStatus: readingStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      BookEntry,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (BookEntry, BaseReferences<_$AppDatabase, $BooksTable, BookEntry>),
      BookEntry,
      PrefetchHooks Function()
    >;
typedef $$AuthorsTableCreateCompanionBuilder =
    AuthorsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> bio,
    });
typedef $$AuthorsTableUpdateCompanionBuilder =
    AuthorsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> bio,
    });

class $$AuthorsTableFilterComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuthorsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuthorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);
}

class $$AuthorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuthorsTable,
          AuthorEntry,
          $$AuthorsTableFilterComposer,
          $$AuthorsTableOrderingComposer,
          $$AuthorsTableAnnotationComposer,
          $$AuthorsTableCreateCompanionBuilder,
          $$AuthorsTableUpdateCompanionBuilder,
          (
            AuthorEntry,
            BaseReferences<_$AppDatabase, $AuthorsTable, AuthorEntry>,
          ),
          AuthorEntry,
          PrefetchHooks Function()
        > {
  $$AuthorsTableTableManager(_$AppDatabase db, $AuthorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> bio = const Value.absent(),
              }) => AuthorsCompanion(id: id, name: name, bio: bio),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> bio = const Value.absent(),
              }) => AuthorsCompanion.insert(id: id, name: name, bio: bio),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuthorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuthorsTable,
      AuthorEntry,
      $$AuthorsTableFilterComposer,
      $$AuthorsTableOrderingComposer,
      $$AuthorsTableAnnotationComposer,
      $$AuthorsTableCreateCompanionBuilder,
      $$AuthorsTableUpdateCompanionBuilder,
      (AuthorEntry, BaseReferences<_$AppDatabase, $AuthorsTable, AuthorEntry>),
      AuthorEntry,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, required String name});
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, Value<String> name});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryEntry,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (
            CategoryEntry,
            BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntry>,
          ),
          CategoryEntry,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => CategoriesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  CategoriesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryEntry,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (
        CategoryEntry,
        BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntry>,
      ),
      CategoryEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$AuthorsTableTableManager get authors =>
      $$AuthorsTableTableManager(_db, _db.authors);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
}
