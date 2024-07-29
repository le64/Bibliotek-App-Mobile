// ignore_for_file: unnecessary_import

import 'dart:ui'; // Importation pour FontWeight

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    // Exemple de livres (remplace-le par ta propre logique pour charger les livres)
    books = [
      Book(title: 'Livre 1', author: 'Auteur 1', format: 'PDF'),
      Book(title: 'Livre 2', author: 'Auteur 2', format: 'TXT'),
    ];
  }

  void _addBookFromFile() async {
    // Ouvre le sélecteur de fichier
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String format = file.extension!.toUpperCase();
      String title = file.name;
      String author = 'Inconnu';

      // Obtient la taille du fichier
      int fileSizeInBytes = file.size;
      String fileSize = (fileSizeInBytes / 1024).toStringAsFixed(2);

      setState(() {
        books.add(Book(title: title, author: author, format: format, fileSize: fileSize));
      });
    }
  }

  void _addBookManually() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController titleController = TextEditingController();
        TextEditingController authorController = TextEditingController();
        TextEditingController categoryController = TextEditingController();

        return AlertDialog(
          title: const Text('Ajouter un livre manuellement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Auteur'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Catégorie'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                String author = authorController.text.trim();
                String format = 'MANUAL'; // Format manuel
                String fileSize = '0.00'; // Taille par défaut

                if (title.isNotEmpty && author.isNotEmpty) {
                  setState(() {
                    books.add(Book(title: title, author: author, format: format, fileSize: fileSize));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showBookDetails(Book book) {
    String selectedStatus = book.readingStatus;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Détails du Livre'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Titre: ${book.title}'),
              const SizedBox(height: 8.0),
              Text('Auteur: ${book.author}'),
              const SizedBox(height: 8.0),
              Text('Format: ${book.format}'),
              const SizedBox(height: 8.0),
              Text('Taille: ${book.fileSize} KB'),
              const SizedBox(height: 16.0),
              const Text('Statut de Lecture:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  ChoiceChip(
                    label: const Text('Lu'),
                    selected: selectedStatus == 'Lu',
                    onSelected: (selected) {
                      setState(() {
                        selectedStatus = 'Lu';
                        book.readingStatus = 'Lu';
                      });
                    },
                  ),
                  ChoiceChip(
                    label: const Text('En cours'),
                    selected: selectedStatus == 'En cours',
                    onSelected: (selected) {
                      setState(() {
                        selectedStatus = 'En cours';
                        book.readingStatus = 'En cours';
                      });
                    },
                  ),
                  ChoiceChip(
                    label: const Text('Déjà lu'),
                    selected: selectedStatus == 'Déjà lu',
                    onSelected: (selected) {
                      setState(() {
                        selectedStatus = 'Déjà lu';
                        book.readingStatus = 'Déjà lu';
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite(Book book) {
    setState(() {
      book.isFavorite = !book.isFavorite;
    });
    // Affiche un snackbar pour confirmer l'ajout aux favoris
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(book.isFavorite ? 'Ajouté aux favoris' : 'Retiré des favoris'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteBook(Book book) {
    setState(() {
      books.remove(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Liste des livres',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 4.0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      title: Text(
                        books[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold), // Mettre le titre en gras
                      ),
                      subtitle: Text('${books[index].author} - ${books[index].format} (${books[index].fileSize} KB)'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String choice) {
                          if (choice == 'details') {
                            _showBookDetails(books[index]);
                          } else if (choice == 'favorite') {
                            _toggleFavorite(books[index]);
                          } else if (choice == 'delete') {
                            _deleteBook(books[index]);
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'details',
                            child: ListTile(
                              leading: Icon(Icons.info),
                              title: Text('Détails'),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'favorite',
                            child: ListTile(
                              leading: Icon(Icons.star),
                              title: Text('Ajouter au favoris'),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Supprimer'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _addBookFromFile,
            tooltip: 'Ajouter un livre depuis un fichier',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: _addBookManually,
            tooltip: 'Ajouter un livre manuellement',
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String format;
  final String fileSize; // Taille du fichier en KB
  String readingStatus; // Statut de lecture (Lu, En cours, Déjà lu)
  bool isFavorite; // Indicateur de favori

  Book({
    required this.title,
    required this.author,
    required this.format,
    this.fileSize = '0.00',
    this.readingStatus = 'Non spécifié',
    this.isFavorite = false,
  });
}
