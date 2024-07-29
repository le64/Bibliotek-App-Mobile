import 'package:bibliotek/register.dart';
import 'package:bibliotek/userManager.dart';
import 'package:bibliotek/user_profil.dart';
import 'package:bibliotek/userssesion.dart';
import 'package:flutter/material.dart'; // Importez correctement votre gestionnaire d'utilisateurs

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ignore: use_key_in_widget_constructors
  LoginPage({Key? key});

  void _handleLogin(BuildContext context) {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  // Vérifier si les identifiants correspondent à une paire valide
  if (UserManager().isValidCredentials(email, password)) {
    // Simuler les informations de l'utilisateur après une connexion réussie
    UserProfile userProfile = UserProfile(
      firstName: 'John',
      lastName: 'Doe',
      email: email,
      location: 'New York, USA',
      favoriteBook: 'The Great Gatsby',
      imageAssetPath: 'assets/images/profil.jpg',
    );

    // Stocker les informations de l'utilisateur dans la session
    UserSession.setUser(userProfile);

    // Authentification réussie, naviguer vers la page d'accueil
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    // Afficher un message d'erreur
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erreur de connexion'),
        content: const Text('Adresse email ou mot de passe incorrect.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    const Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Adresse email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Gérer la connexion
                        _handleLogin(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Se connecter'),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Naviguer vers la page d'inscription
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterApp()),
                        );
                      },
                      child: const Text(
                        "Vous n'avez pas de compte ? Inscrivez-vous.",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
