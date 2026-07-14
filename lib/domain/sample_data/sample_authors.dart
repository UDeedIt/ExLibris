// lib/domain/sample_data/sample_authors.dart

import 'package:ex_libris/domain/entities/author.dart';

/// Static list of sample authors used to seed an empty Authors table.
///
/// Intended for demo and portfolio purposes only.
const List<Author> kSampleAuthors = [
  Author(
    id: 0, // Placeholder; will be replaced by the database-generated id.
    name: 'George Orwell',
    bio:
    'English novelist and essayist, known for "1984" and "Animal Farm", often exploring themes of totalitarianism.',
  ),
  Author(
    id: 0,
    name: 'Harper Lee',
    bio:
    'American novelist best known for "To Kill a Mockingbird", a classic of modern American literature.',
  ),
  Author(
    id: 0,
    name: 'J.R.R. Tolkien',
    bio:
    'English writer and philologist, author of "The Hobbit" and "The Lord of the Rings".',
  ),
  Author(
    id: 0,
    name: 'Jane Austen',
    bio:
    'English novelist known for works such as "Pride and Prejudice" and "Sense and Sensibility".',
  ),
  Author(
    id: 0,
    name: 'Miguel de Cervantes',
    bio:
    'Spanish writer widely regarded as one of the greatest authors, best known for "Don Quixote".',
  ),
  Author(
    id: 0,
    name: 'Fyodor Dostoevsky',
    bio:
    'Russian novelist and philosopher, author of "Crime and Punishment" and "The Brothers Karamazov".',
  ),
];
