// lib/presentation/books/view/author_picker_dialog.dart

import 'package:flutter/material.dart';
import 'package:ex_libris/domain/entities/author.dart';
import 'package:ex_libris/data/repositories/author_repository.dart';

/// Shows a dialog that allows the user to pick an existing author from [repo].
///
/// Returns the selected [Author], or null if the dialog was cancelled or if
/// there are no authors to choose from.
Future<Author?> showAuthorPickerDialog({
  required BuildContext context,
  required AuthorRepository authorRepository,
}) async {
  final authors = await authorRepository.getAllAuthors();
  if (authors.isEmpty) {
    // No authors available; nothing to show.
    return null;
  }

  if (!context.mounted) return null;

  return showDialog<Author>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Select author'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: authors.length,
            itemBuilder: (context, index) {
              final author = authors[index];
              return ListTile(
                title: Text(author.name),
                subtitle: author.bio != null && author.bio!.trim().isNotEmpty
                    ? Text(
                  author.bio!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
                    : null,
                onTap: () {
                  Navigator.of(dialogContext).pop(author);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(null),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
