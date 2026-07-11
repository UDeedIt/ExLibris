// lib/domain/sample_data/sample_categories.dart

import 'package:ex_libris/domain/entities/category.dart';

/// Static list of sample categories used to seed an empty database.
///
/// Intended for demo and portfolio purposes only.
const List<Category> kSampleCategories = [
  Category(
    id: 0, // Placeholder; will be replaced by the database-generated id.
    name: 'Dystopian',
    description: 'Novels set in oppressive or controlled societies.',
  ),
  Category(
    id: 0,
    name: 'Classic',
    description: 'Widely recognized works of enduring value.',
  ),
  Category(
    id: 0,
    name: 'Fantasy',
    description: 'Stories with magical or supernatural elements.',
  ),
  Category(
    id: 0,
    name: 'Historical',
    description: 'Fiction set in a past time period.',
  ),
  Category(
    id: 0,
    name: 'Romance',
    description: 'Stories focused on romantic relationships.',
  ),
];
