// lib/presentation/home/view/home_shell_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/books/view/book_list_screen.dart';
import 'package:ex_libris/presentation/authors/view/author_list_screen.dart';
import 'package:ex_libris/presentation/categories/view/category_list_screen.dart';

import '../../../l10n/app_localizations.dart';

/// Root shell with bottom navigation for Books, Authors and Categories.
class HomeShellScreen extends ConsumerStatefulWidget {
  const HomeShellScreen({super.key});

  @override
  ConsumerState<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends ConsumerState<HomeShellScreen> {
  int _currentIndex = 0;

  static const _pages = [
    BookListScreen(),
    AuthorListScreen(),
    CategoryListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.menu_book_outlined),
            selectedIcon: const Icon(Icons.menu_book),
            label: loc.navBooks, // 'Books'
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: loc.navAuthors//'Authors',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: loc.navCategories // 'Categories',
          ),
        ],
      ),
    );
  }
}
