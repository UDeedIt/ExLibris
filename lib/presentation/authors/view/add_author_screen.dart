// lib/presentation/authors/view/add_author_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ex_libris/domain/entities/author.dart';
import 'package:ex_libris/presentation/authors/viewmodel/author_list_view_model.dart';

/// Simple form screen for creating a new author entry.
class AddAuthorScreen extends ConsumerStatefulWidget {
  const AddAuthorScreen({super.key});

  @override
  ConsumerState<AddAuthorScreen> createState() => _AddAuthorScreenState();
}

class _AddAuthorScreenState extends ConsumerState<AddAuthorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

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
        title: const Text('Add Author'),
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

    final notifier = ref.read(authorListViewModelProvider.notifier);

    final newAuthor = Author(
      id: 0, // Will be replaced by the database-generated id.
      name: _nameController.text.trim(),
      bio: _bioController.text.trim().isEmpty
          ? null
          : _bioController.text.trim(),
    );

    await notifier.addAuthor(newAuthor);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
