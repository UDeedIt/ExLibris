// lib/presentation/splash/view/splash_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/presentation/books/viewmodel/book_list_view_model.dart';
import 'package:ex_libris/presentation/home/view/home_shell_screen.dart';
import 'package:ex_libris/l10n/app_localizations.dart';

/// Initial splash screen displayed when the app launches.
///
/// Performs a basic warm-up (e.g. first book load) and then navigates
/// to the main application shell.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Schedule warm-up and navigation after the first frame.
    Future.microtask(_initializeAndNavigate);
  }

  Future<void> _initializeAndNavigate() async {
    // Basic warm-up: trigger initial book load so seeding runs if needed.
    try {
      await ref.read(bookListViewModelProvider.notifier).loadBooks();

    } catch (_) {
      // Errors during warm-up are ignored for the splash.
    }

    // Optional small delay to keep the splash visible briefly.
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const HomeShellScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: 72,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.appTitle, //'Ex Libris',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.splashSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
