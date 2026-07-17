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
    // Localized labels for navigation.
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      // No AppBar here; each tab screen provides its own AppBar.
      // The main content is provided by an IndexedStack so that
      // each tab preserves its state while switching.
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // Bottom navigation between Books, Authors and Categories.
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
            label: loc.navBooks,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: loc.navAuthors,
          ),
          NavigationDestination(
            icon: const Icon(Icons.category_outlined),
            selectedIcon: const Icon(Icons.category),
            label: loc.navCategories,
          ),
        ],
      ),
    );
  }
}
