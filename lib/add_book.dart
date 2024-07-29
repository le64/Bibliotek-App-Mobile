// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:bibliotek/book.dart';
import 'package:bibliotek/database_helper.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  bool _isLoading = false; // State variable to track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Livre'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  'Veuillez remplir les champs',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 56.0),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le titre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 46.0),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'Auteur',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer l\'auteur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 46.0),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.category_sharp),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la catégorie';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true; // Set loading state to true
                          });
                          final dbHelper = DatabaseHelper();
                          await dbHelper.insertBook(Book(
                            title: _titleController.text,
                            author: _authorController.text,
                          ).toMap());
                          setState(() {
                            _isLoading = false; // Set loading state to false
                          });
                          Navigator.pop(context, true);
                        }
                      },
                child: _isLoading
                    ? const SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3.0,
                        ),
                      )
                    : const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
