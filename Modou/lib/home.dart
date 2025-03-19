import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modou/app_layout.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'auth_token');

    setState(() {
      _token = token;
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double margin = 16.0;

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFF6F2ED),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prochain évènement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF90afa6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          '14 mars 2025 à 16h',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Café avec Mathilde ☕',
                          style: TextStyle(color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF795548),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Modifier'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Suggestions',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SuggestionCard(
              text:
                  "Ça fait longtemps que vous n'avez pas parlé à Paul. Pourquoi ne pas lui proposer un verre 🍹 ?",
              screenWidth: screenWidth,
              margin: margin,
            ),
            SuggestionCard(
              text:
                  "C'est le demi-anniversaire de Laëtitia, envoye lui un message pour lui souhaiter ! 🎉",
              screenWidth: screenWidth,
              margin: margin,
            ),
            SuggestionCard(
              text:
                  "C'est dimanche, pourquoi pas une balade? Pauline aime les escapades nature. 🌳",
              screenWidth: screenWidth,
              margin: margin,
            ),
            const SizedBox(height: 20),
            const Text(
              'Conseils',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            AdviceCard(
              text:
                  "Les messages vocaux sont souvent perçus comme plus chaleureux que les SMS. 🔔",
              screenWidth: screenWidth,
              margin: margin,
            ),
            AdviceCard(
              text:
                  "Réservez un moment chaque semaine pour passer un appel à un proche. 📞",
              screenWidth: screenWidth,
              margin: margin,
            ),
            AdviceCard(
              text:
                  "N'hésitez pas à poser une question simple, ça brise la glace (sans trop de pression). 🧊",
              screenWidth: screenWidth,
              margin: margin,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );

  }
}

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key, required this.text, required this.screenWidth, required this.margin});

  final String text;
  final double screenWidth;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 2 * margin, 
      margin: const EdgeInsets.symmetric(vertical: 5), 
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(text),
        ),
      ),
    );
  }
}

class AdviceCard extends StatelessWidget {
  const AdviceCard({super.key, required this.text, required this.screenWidth, required this.margin});

  final String text;
  final double screenWidth;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 2 * margin,
      margin: const EdgeInsets.symmetric(vertical: 5), 
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(text),
        ),
      ),
    );
  }
}
