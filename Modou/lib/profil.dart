import 'package:flutter/material.dart';
import 'package:modou/api_service.dart';
import 'parameters.dart';

class ProfilPage extends StatefulWidget {
  final String token; // Ajout du token
  const ProfilPage({super.key, required this.token});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String username = "Chargement...";

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final response = await ApiService.getUserProfile(widget.token);
    
    if (response != null && response.containsKey('username')) {
      setState(() {
        username = response['username']; // Récupère le nom d'utilisateur
      });
    } else {
      setState(() {
        username = "Erreur de chargement";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F2ED),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
        'Modou',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 35,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/Avatar.png'),
              ),
              const SizedBox(height: 10),

              // Nom et Bio
              Text(
                username,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              // Statistiques
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                ),
                child: const Column(
                  children: [
                    Text("Statistiques", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("🌟 Interactions totales : 120"),
                    Text("📅 Moyenne d'interactions / semaine : 5"),
                    Text("📞 Dernier contact : il y a 2 jours"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Historique des interactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: const [
                            ListTile(
                              leading: Icon(Icons.call, color: Colors.green),
                              title: Text("Appel avec Maman"),
                              subtitle: Text("Durée : 15 min • il y a 3 jours"),
                            ),
                            ListTile(
                              leading: Icon(Icons.message, color: Colors.blue),
                              title: Text("Message envoyé à Pierre"),
                              subtitle: Text("« Salut, comment tu vas ? » • il y a 1 semaine"),
                            ),
                            ListTile(
                              leading: Icon(Icons.people, color: Colors.orange),
                              title: Text("Rencontre avec Sophie"),
                              subtitle: Text("Café en terrasse • il y a 2 semaines"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.settings, color: Colors.white),
                label: const Text("Paramètres"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ParametersPage()));
                },
              ),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text("Déconnexion"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
