import 'package:bibliotek/userssesion.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required userProfile});

  @override
  Widget build(BuildContext context) {
    final userProfile = UserSession.getUser();

    if (userProfile == null) {
      return Scaffold(
        body: Center(
          child: Text('Aucun utilisateur connecté.'),
        ),
      );
    }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  'Profil de l\'utilisateur',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(userProfile.imageAssetPath),
              ),
              const SizedBox(height: 20),
              Text(
                '${userProfile.firstName} ${userProfile.lastName}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                userProfile.email,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Localisation', userProfile.location),
              const SizedBox(height: 8),
              _buildInfoRow('Livre favori', userProfile.favoriteBook),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String location;
  final String favoriteBook;
  final String imageAssetPath;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.location,
    required this.favoriteBook,
    required this.imageAssetPath,
  });
}
