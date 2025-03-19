import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static late String apiUrl;
  static bool _isInitialized = false;

  // Charger la configuration une seule fois
  static Future<void> initialize() async {
    if (!_isInitialized) {
      final String configString = await rootBundle.loadString('assets/config.json');
      final Map<String, dynamic> config = json.decode(configString);
      apiUrl = config['API_URL'];
      _isInitialized = true;
    }
  }

  // Inscription d'un utilisateur
  static Future<http.Response> registerUser(String email, String password, String username) async {
    await initialize(); 
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/users/sign-up'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password, "username": username}),
      );
      return response;
    } catch (e) {
      print('Erreur lors de l’inscription : $e');
      throw Exception('Échec de l’inscription');
    }
  }

  // Connexion utilisateur
  static Future<String?> login(String email, String password) async {
    await initialize();
          final response = await http.post(
        Uri.parse('$apiUrl/users/sign-in'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
    return response.body; // Le token JWT est dans le body
  } else {
    print("Erreur de connexion: ${response.body}");
    return null;
  }
}

  // Récupérer le profil utilisateur (avec token)
  static Future<Map<String, dynamic>?> getUserProfile(String token) async {
    await initialize();
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/users'), 
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
    return data.isNotEmpty ? data[0] : null;
      } else {
        print('Échec de récupération du profil : ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération du profil : $e');
      return null;
    }
  }
}
