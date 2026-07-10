// lib/presentation/authors/view/edit_author_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/domain/entities/author.dart';
import 'package:ex_libris/presentation/authors/viewmodel/author_list_view_model.dart';

/// Form screen for editing an existing author entry.
class EditAuthorScreen extends ConsumerStatefulWidget {
  const EditAuthorScreen({
    super.key,
    required this.author,
  });

  /// Author to be edited.
  final Author author;

  @override
  ConsumerState<EditAuthorScreen> createState() => _EditAuthorScreenState();
}

class _EditAuthorScreenState extends ConsumerState<EditAuthorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.author.name);
    _bioController = TextEditingController(text: widget.author.bio ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Author'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio (optional)',
                ),
                maxLines: 3,
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

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authorListViewModelProvider.notifier);

    final updatedAuthor = Author(
      id: widget.author.id,
      name: _nameController.text.trim(),
      bio: _bioController.text.trim().isEmpty
          ? null
          : _bioController.text.trim(),
    );

    await notifier.updateAuthor(updatedAuthor);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
