// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:bibliotek/add_book.dart';
import 'package:bibliotek/book_list.dart';
import 'package:bibliotek/category_livre.dart';
import 'package:bibliotek/login.dart';
import 'package:bibliotek/onboarding_screen.dart';
import 'package:bibliotek/user_profil.dart';
import 'package:bibliotek/userssesion.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importez le fichier de session utilisateur

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Bibliothèque',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/onboarding': (context) => OnboardingScreen(
              onCompleted: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onBoarding', true);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
        '/login': (context) => LoginPage(),
        '/home': (context) => MainPage(),
        '/addbook': (context) => AddBook(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;

    // Obtenez le profil utilisateur depuis UserSession
    final userProfile = UserSession.getUser();

    // Déterminez quel widget afficher en fonction de l'index
    if (_currentIndex == 0) {
      bodyWidget = const BookList();
    } else if (_currentIndex == 1) {
      bodyWidget = const CategoryLivre();
    } else if (_currentIndex == 2) {
      // Vérifiez si un utilisateur est connecté avant d'afficher la page de profil
      if (userProfile != null) {
        bodyWidget = ProfilePage(userProfile: userProfile);
      } else {
        bodyWidget = const PlaceholderWidget(title: 'Aucun profil utilisateur');
      }
    } else {
      bodyWidget = const PlaceholderWidget(title: 'Page inconnue');
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                16, 20, 16, 12), // Ajustez les marges selon vos besoins
            color: Colors.blue, // Couleur d'arrière-plan de l'en-tête
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Bibliotek',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    // Réinitialiser les informations de session
                    UserSession.setUser(null);

                    // Naviguer vers la page de connexion
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Expanded(
            child: bodyWidget, // Votre contenu principal
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Livres',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catégorie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
