import 'package:flutter/material.dart';

class CategoryLivre extends StatefulWidget {
  const CategoryLivre({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryLivreState createState() => _CategoryLivreState();
}

class Category {
  final String name;

  Category({required this.name});
}

class _CategoryLivreState extends State<CategoryLivre> {
  List<Category> categories = [
    Category(name: 'Pleasure'),
    Category(name: 'Movies'),
  ];

  void _showAddCategoryDialog() {
    String categoryName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une catégorie'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Nom de la catégorie'),
                  onChanged: (value) {
                    categoryName = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Ajouter'),
              onPressed: () {
                if (categoryName.isNotEmpty) {
                  setState(() {
                    categories.add(Category(name: categoryName));
                  });
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                }
              },
            ),
          ],
        );
      },
    );
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'LISTE DES CATÉGORIES',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: categories.isEmpty
                  ? const Center(
                      child: Text('Aucune catégorie trouvée', style: TextStyle(fontSize: 18.0)),
                    )
                  : ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            title: Text(
                              categories[index].name,
                              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  categories.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
