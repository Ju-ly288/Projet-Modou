import 'package:flutter/material.dart';
import 'package:modou/api_service.dart';
import 'package:modou/home.dart';
import 'package:modou/login.dart';
import 'package:modou/parameters.dart';
import 'sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.initialize(); 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(), // Définir SignUpPage comme la page d'accueil
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/parameters': (context) => ParametersPage(), // Ajouter la route pour ParametersPage
      },
    );
  }
}