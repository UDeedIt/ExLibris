// lib/presentation/books/view/category_picker_dialog.dart

import 'package:flutter/material.dart';
import 'package:ex_libris/data/repositories/category_repository.dart';
import 'package:ex_libris/domain/entities/category.dart';

/// Shows a dialog that allows the user to pick one or more existing categories
/// from [categoryRepository].
///
/// [initiallySelectedNames] contains category names that should start as
/// selected in the UI.
///
/// Returns the selected [Category] list, or an empty list if cancelled or if
/// there are no categories to choose from.
Future<List<Category>> showCategoryMultiPickerDialog({
  required BuildContext context,
  required CategoryRepository categoryRepository,
  required List<String> initiallySelectedNames,
}) async {
  final categories = await categoryRepository.getAllCategories();
  if (categories.isEmpty) {
    return [];
  }

  if (!context.mounted) return [];

  // Track selected names in a local set.
  final selectedNames = initiallySelectedNames.toSet();

  final result = await showDialog<List<Category>>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Select categories'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedNames.contains(category.name);

                  return CheckboxListTile(
                    title: Text(category.name),
                    subtitle:
                    category.description != null &&
                        category.description!.trim().isNotEmpty
                        ? Text(
                      category.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        : null,
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedNames.add(category.name);
                        } else {
                          selectedNames.remove(category.name);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(<Category>[]),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  final selected = categories
                      .where((c) => selectedNames.contains(c.name))
                      .toList();
                  Navigator.of(dialogContext).pop(selected);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
  );

  return result ?? <Category>[];
}
