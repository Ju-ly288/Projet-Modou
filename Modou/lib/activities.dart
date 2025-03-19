import 'package:flutter/material.dart';
import 'package:modou/app_layout.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {

  final List<String> _activities = [
    '🍕 Atelier pizza maison',
    '🖌️ Atelier peinture ou dessin',
    '🎲 Soirée jeux de société',
    '🧗 Escalade en salle',
    '🍃 Promenade dans un parc',
    '🎭 Spectacle ou théâtre local',
    '🏓 Ping-pong ou billard',
    '📚 Lecture à voix haute',
    '🎤 Karaoké',
    '🥾 Randonnée facile',
  ];

  final List<String> _jeux = [
    '🎲 Dice party',
    '🃏 Crapette',
    '♟️ Échecs',
    '🅰️ Scrabble',
    '♠️ Poker',
  ];

  final List<String> _loisirs = [
    '🖥️ Film synchronisée',
    '🎙️ Discussions thématiques',
    '🎭 Théâtre',
    '📚 Lecture',
    '🎵 Musique',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED),
      appBar: CustomAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Activités',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 160, 
                child: ListView.builder(
                  scrollDirection: Axis.vertical,  
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    final activity = _activities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        activity,
                        style: const TextStyle(fontSize: 18), 
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logique manquante
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF795548),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Aide à choisir'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlanifierPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF795548),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Planifier un RDV'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'En ligne',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Clique sur l'activité pour copier un lien à partager à ton/tes proches.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              const Text(
                'Jeux',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 120, 
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _jeux.length,
                  itemBuilder: (context, index) {
                    final jeu = _jeux[index];
                    return _buildActivityItem(
                      jeu,
                      onTap: () {
                        final snackBar = SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.copy, color: Colors.white),
                              SizedBox(width: 10),
                              Text('Lien copié'),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                          // ignore: deprecated_member_use
                          backgroundColor: Colors.black.withOpacity(0.7),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Loisirs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 120, 
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _loisirs.length,
                  itemBuilder: (context, index) {
                    final loisir = _loisirs[index];
                    return _buildActivityItem(
                      loisir,
                      onTap: () {
                        final snackBar = SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.copy, color: Colors.white),
                              SizedBox(width: 10),
                              Text('Lien copié'),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                          // ignore: deprecated_member_use
                          backgroundColor: Colors.black.withOpacity(0.7),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );  }

  Widget _buildActivityItem(String activity, {VoidCallback? onTap}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(activity),
        onTap: onTap,
      ),
    );
  }
}

class PlanifierPage extends StatefulWidget {
  final String? initialActivity;

  const PlanifierPage({super.key, this.initialActivity});

  @override
  _PlanifierPageState createState() => _PlanifierPageState();
}

class _PlanifierPageState extends State<PlanifierPage> {
  final TextEditingController _activityController = TextEditingController();
  final List<DateTime> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialActivity != null) {
      _activityController.text = widget.initialActivity!;
    }
  }


  void _addAvailability() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            setState(() {
              _selectedDates.add(DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              ));
            });
          }
        });
      }
    });
  }

  void _proposeActivity() {
    final snackBar = SnackBar(
      content: const Row(
        children: [
          Icon(Icons.copy, color: Colors.white),
          SizedBox(width: 10),
          Text('Lien copié'),
        ],
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ActivitiesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Planifier',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Nom du/des proche(s)'),
            const SizedBox(height: 10),
            _buildTextField('Nom de l\'activité'),
            const SizedBox(height: 10),
            _buildTextField('Lieu de l\'activité'),
            const SizedBox(height: 10),
            _buildTextField('Durée de l\'activité'),
            const SizedBox(height: 20),
            const Text(
              'Disponibilités',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: _addAvailability,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'Ajouter une disponibilité',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ..._selectedDates.map((date) => Text(
              '${date.day}/${date.month}/${date.year} à ${date.hour}:${date.minute}',
              style: const TextStyle(fontSize: 16),
            )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: _proposeActivity,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'Proposer l\'activité à un proche',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
Widget _buildTextField( String label) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        );
      }
