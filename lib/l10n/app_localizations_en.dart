// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ex Libris';

  @override
  String get splashSubtitle => 'Your personal library';

  @override
  String get navBooks => 'Books';

  @override
  String get navAuthors => 'Authors';

  @override
  String get navCategories => 'Categories';
}
