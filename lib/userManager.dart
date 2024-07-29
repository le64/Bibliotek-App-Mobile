// ignore_for_file: file_names

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  // Liste de paires d'identifiants valides
  final Map<String, String> _validCredentials = {};

  // Méthode pour ajouter de nouveaux identifiants
  void addCredentials(String email, String password) {
    _validCredentials[email] = password;
  }

  // Méthode pour vérifier les identifiants
  bool isValidCredentials(String email, String password) {
    return _validCredentials.containsKey(email) && _validCredentials[email] == password;
  }
}
