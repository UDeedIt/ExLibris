// lib/domain/sample_data/sample_books.dart

import 'package:ex_libris/domain/entities/book.dart';

/// Static list of sample books used to seed an empty database.
///
/// This is intended for demo and portfolio purposes only and should not
/// be relied on for production data.
const List<Book> kSampleBooks = [
  Book(
    id: 0, // Placeholder; will be replaced by the database-generated id.
    title: '1984',
    authorName: 'George Orwell',
    isbn: '9780451524935',
    readingStatus: 'to_read',
    categories: ['Dystopian', 'Classic'],
  ),
  Book(
    id: 0,
    title: 'Animal Farm',
    authorName: 'George Orwell',
    isbn: '9780451526342',
    readingStatus: 'to_read',
    categories: ['Political satire', 'Allegory'],
  ),
  Book(
    id: 0,
    title: 'To Kill a Mockingbird',
    authorName: 'Harper Lee',
    isbn: '9780061120084',
    readingStatus: 'to_read',
    categories: ['Classic', 'Historical'],
  ),
  Book(
    id: 0,
    title: 'The Hobbit',
    authorName: 'J.R.R. Tolkien',
    isbn: '9780547928227',
    readingStatus: 'reading',
    categories: ['Fantasy'],
  ),
  Book(
    id: 0,
    title: 'Pride and Prejudice',
    authorName: 'Jane Austen',
    isbn: '9780141439518',
    readingStatus: 'finished',
    categories: ['Romance', 'Classic'],
  ),
  Book(
    id: 0,
    title: 'Don Quixote',
    authorName: 'Miguel de Cervantes',
    isbn: '9780060934347',
    readingStatus: 'to_read',
    categories: ['Classic', 'Adventure'],
  ),
  Book(
    id: 0,
    title: 'Crime and Punishment',
    authorName: 'Fyodor Dostoevsky',
    isbn: '9780143058144',
    readingStatus: 'to_read',
    categories: ['Russian literature', 'Psychological'],
  ),
];
