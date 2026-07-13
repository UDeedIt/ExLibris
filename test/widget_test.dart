// test/widget_test.dart

import 'package:ex_libris/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'ExLibrisApp builds and shows splash title',
        (WidgetTester tester) async {
      // Build the app wrapped in ProviderScope (as in main()).
      await tester.pumpWidget(
        const ProviderScope(
          child: ExLibrisApp(),
        ),
      );

      // Initial pump builds the splash screen.
      await tester.pump();

      // Verify that the splash displays the app title.
      expect(find.text('Ex Libris'), findsWidgets);
    },
  );
}
