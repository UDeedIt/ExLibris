// lib/presentation/books/view/edit_book_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/domain/entities/book.dart';
import 'package:ex_libris/presentation/books/viewmodel/book_list_view_model.dart';

import '../../../data/providers/data_providers.dart';
import 'author_picker_dialog.dart';
import 'category_picker_dialog.dart';

/// Form screen for editing an existing book entry.
class EditBookScreen extends ConsumerStatefulWidget {
  const EditBookScreen({
    super.key,
    required this.book,
  });

  /// Book to be edited.
  final Book book;

  @override
  ConsumerState<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends ConsumerState<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _isbnController;
  final _categoriesController = TextEditingController();

  List<String> _selectedCategoryNames = [];
  late String _readingStatus;


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController =
        TextEditingController(text: widget.book.authorName ?? '');
    _isbnController = TextEditingController(text: widget.book.isbn ?? '');
    _readingStatus = widget.book.readingStatus;
    _selectedCategoryNames = List<String>.from(widget.book.categories);
    _categoriesController.text = _selectedCategoryNames.join(', ');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _categoriesController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
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
                decoration: InputDecoration(
                  labelText: 'Author (optional)',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.list),
                    tooltip: 'Pick existing author',
                    onPressed: _onPickExistingAuthorPressed,
                  ),
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

              TextFormField(
                controller: _categoriesController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Categories (optional)',
                  hintText: 'Tap to pick categories',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.list),
                    tooltip: 'Pick existing categories',
                    onPressed: _onPickExistingCategoriesPressed,
                  ),
                ),
                onTap: _onPickExistingCategoriesPressed,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _readingStatus,
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
                child: const Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _onPickExistingAuthorPressed() async {
    final repo = ref.read(authorRepositoryProvider);

    final selected = await showAuthorPickerDialog(
      context: context,
      authorRepository: repo,
    );

    if (selected != null && mounted) {
      setState(() {
        _authorController.text = selected.name;
      });
    }
  }

  /// Opens a dialog to pick one or more existing categories from the database.
  Future<void> _onPickExistingCategoriesPressed() async {
    final repo = ref.read(categoryRepositoryProvider);

    final selected = await showCategoryMultiPickerDialog(
      context: context,
      categoryRepository: repo,
      initiallySelectedNames: _selectedCategoryNames,
    );

    if (selected.isNotEmpty && mounted) {
      setState(() {
        _selectedCategoryNames = selected.map((c) => c.name).toList();
        _categoriesController.text = _selectedCategoryNames.join(', ');
      });
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(bookListViewModelProvider.notifier);

    final updatedBook = Book(
      id: widget.book.id,
      title: _titleController.text.trim(),
      authorName: _authorController.text.trim().isEmpty
          ? null
          : _authorController.text.trim(),
      isbn: _isbnController.text.trim().isEmpty
          ? null
          : _isbnController.text.trim(),
      readingStatus: _readingStatus,
      categories: _selectedCategoryNames, //widget.book.categories,
    );

    await notifier.updateBook(updatedBook);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
