// test/widget_test.dart

import 'package:ex_libris/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExLibrisApp shows book list screen with add button',
          (WidgetTester tester) async {
        // Build the app wrapped in ProviderScope (as in main()).
        await tester.pumpWidget(
          const ProviderScope(
            child: ExLibrisApp(),
          ),
        );

        // Allow initial frames to settle (e.g., initial load).
        await tester.pumpAndSettle();

        // Verify that the main screen title is shown.
        expect(find.text('Ex Libris'), findsOneWidget);

        // Verify that the FloatingActionButton with the add icon is present.
        expect(find.byIcon(Icons.add), findsOneWidget);
      });
}
