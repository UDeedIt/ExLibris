// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/books/view/book_list_screen.dart';
import 'package:ex_libris/presentation/authors/view/author_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ExLibrisApp(),
    ),
  );
}

class ExLibrisApp extends StatelessWidget {
  const ExLibrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ex Libris',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const BookListScreen(), // AuthorListScreen(),
    );
  }
}
