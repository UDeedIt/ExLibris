// lib/presentation/books/view/add_book_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/domain/entities/book.dart';
import 'package:ex_libris/presentation/books/viewmodel/book_list_view_model.dart';

/// Simple form screen for creating a new book entry.
///
/// This is intentionally minimal for the initial portfolio version.
class AddBookScreen extends ConsumerStatefulWidget {
  const AddBookScreen({super.key});

  @override
  ConsumerState<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends ConsumerState<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _isbnController = TextEditingController();

  String _readingStatus = 'to_read';

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author (optional)',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _isbnController,
                decoration: const InputDecoration(
                  labelText: 'ISBN (optional)',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _readingStatus,
                decoration: const InputDecoration(
                  labelText: 'Reading status',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'to_read',
                    child: Text('To read'),
                  ),
                  DropdownMenuItem(
                    value: 'reading',
                    child: Text('Reading'),
                  ),
                  DropdownMenuItem(
                    value: 'finished',
                    child: Text('Finished'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _readingStatus = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _onSubmit,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(bookListViewModelProvider.notifier);

    final newBook = Book(
      id: 0, // Will be replaced by the repository/database.
      title: _titleController.text.trim(),
      authorName: _authorController.text.trim().isEmpty
          ? null
          : _authorController.text.trim(),
      isbn: _isbnController.text.trim().isEmpty
          ? null
          : _isbnController.text.trim(),
      readingStatus: _readingStatus,
      categories: const [],
    );

    await notifier.addBook(newBook);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
