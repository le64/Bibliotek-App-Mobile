// userSession.dart

// Assurez-vous que ce chemin est correct pour accéder à la classe UserProfile

import 'package:bibliotek/user_profil.dart';

class UserSession {
  // Stocke les informations de l'utilisateur connecté
  static UserProfile? currentUser;

  // Définit les informations de l'utilisateur connecté
  static void setUser(UserProfile? user) {
    currentUser = user;
  }

  // Obtient les informations de l'utilisateur connecté
  static UserProfile? getUser() {
    return currentUser;
  }

  // Réinitialise les informations de l'utilisateur
  static void clearUser() {
    currentUser = null;
  }
}
