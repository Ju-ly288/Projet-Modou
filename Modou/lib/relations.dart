import 'package:flutter/material.dart';
import 'package:modou/app_layout.dart';
import 'AddRelation.dart';


class RelationsPage extends StatefulWidget {
  const RelationsPage({Key? key}) : super(key: key);

  @override
  _RelationsPageState createState() => _RelationsPageState();
}

class _RelationsPageState extends State<RelationsPage> {
  String _searchText = '';

  // Sample data for proches (replace with your actual data source)
  final List<Proche> _proches = [
    Proche(
        name: 'Papa',
        relationship: 'Père',
        distance: '10 km',
        favoriteActivities: ['Jardinage', 'Lecture'],
        interactionMode: 'Appels téléphoniques',
        imageName: 'Papa.png'),
    Proche(
        name: 'Tonton Fred',
        relationship: 'Oncle',
        distance: '50 km',
        favoriteActivities: ['Football', 'BBQ'],
        interactionMode: 'Visites',
        imageName: 'Tonton_Fred.png'),
    Proche(
        name: 'Sylvie',
        relationship: 'Amie',
        distance: '5 km',
        favoriteActivities: ['Cinéma', 'Shopping'],
        interactionMode: 'SMS',
        imageName: 'Sylvie.png'),
    Proche(
        name: 'Paul',
        relationship: 'Collègue',
        distance: '2 km',
        favoriteActivities: ['Café', 'Tennis'],
        interactionMode: 'Face à face',
        imageName: 'Paul.png'),
    Proche(
        name: 'Nana',
        relationship: 'Cousine',
        distance: '25 km',
        favoriteActivities: ['Voyage', 'Randonnée'],
        interactionMode: 'WhatsApp',
        imageName: 'Nana.png'),
    Proche(
        name: 'Patchie',
        relationship: 'Voisin',
        distance: '1 km',
        favoriteActivities: ['Jeux de société', 'Promenade'],
        interactionMode: 'Discussions',
        imageName: 'Patchie.png'),
    Proche(
        name: 'Mamie',
        relationship: 'Grand-mère',
        distance: '20 km',
        favoriteActivities: ['Tricot', 'Pâtisserie'],
        interactionMode: 'Appels téléphoniques',
        imageName: 'Mamie.png'),
    Proche(
        name: 'Pépoune',
        relationship: 'Ami d\'enfance',
        distance: '100 km',
        favoriteActivities: ['Jeux vidéo', 'Musique'],
        interactionMode: 'Messagerie en ligne',
        imageName: 'Pepoune.png'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFF6F2ED), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Proches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:  Color(0xFFF6F2ED),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un proche',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80), 
                itemCount: _proches.length,
                itemBuilder: (context, index) {
                  final proche = _proches[index];
                  if (_searchText.isNotEmpty &&
                      !proche.name.toLowerCase().contains(_searchText.toLowerCase())) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    color: const Color(0xFF70A193),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: _buildProcheAvatar(proche),
                      title: Text(proche.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert, color: Color(0xFFF6F2ED)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcheDetailsPage(
                                index: index,
                                proche: proche,
                                onProcheUpdated: (updatedProche) {
                                  setState(() {
                                    _proches[index] = updatedProche;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProche = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRelation()),
          );

          if (newProche != null && newProche is Proche) {
            setState(() {
              _proches.add(newProche);
            });
          }
        },
        backgroundColor: const Color(0xFFF6F2ED), 
        child: const Icon(
          Icons.add,
          color: Color(0xFF795548), 
          ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

 Widget _buildProcheAvatar(Proche proche) {

    final imagePath = 'images/${proche.imageName}'; 

    return CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      onBackgroundImageError: (exception, stackTrace) {
      },
    );
  }
}


class Proche {
  String name;
  String relationship;
  String distance;
  List<String> favoriteActivities;
  String interactionMode;
  String imageName;


  Proche({
    required this.name,
    required this.relationship,
    required this.distance,
    required this.favoriteActivities,
    required this.interactionMode,
    required this.imageName,
  });
}

class ProcheDetailsPage extends StatefulWidget {
  final int index;
  final Proche proche;
  final Function(Proche) onProcheUpdated;

  const ProcheDetailsPage({
    super.key,
    required this.index,
    required this.proche,
    required this.onProcheUpdated,
  });

  @override
  _ProcheDetailsPageState createState() => _ProcheDetailsPageState();
}

class _ProcheDetailsPageState extends State<ProcheDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _relationshipController;
  late TextEditingController _distanceController;
  late TextEditingController _favoriteActivitiesController;
  late TextEditingController _interactionModeController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.proche.name);
    _relationshipController = TextEditingController(text: widget.proche.relationship);
    _distanceController = TextEditingController(text: widget.proche.distance);
    _favoriteActivitiesController =
        TextEditingController(text: widget.proche.favoriteActivities.join(', '));
    _interactionModeController = TextEditingController(text: widget.proche.interactionMode);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _distanceController.dispose();
    _favoriteActivitiesController.dispose();
    _interactionModeController.dispose();
    super.dispose();
  }
    Widget _buildTextField(TextEditingController controller, String label) {
        return TextFormField(
          controller: controller,
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

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF6F2ED), 
    appBar: CustomAppBar(), 
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
            Text(
            'À propos de ${widget.proche.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 16),
          _buildProcheAvatar(widget.proche),
          const SizedBox(height: 25),
          Expanded(
            child: ListView(
              children: [
                _buildTextField(_nameController, 'Nom'),
                const SizedBox(height: 12),
                _buildTextField(_relationshipController, 'Lien avec vous'),
                const SizedBox(height: 12),
                _buildTextField(_distanceController, 'Distance'),
                const SizedBox(height: 12),
                _buildTextField(_favoriteActivitiesController, 'Activités préférées'),
                const SizedBox(height: 12),
                _buildTextField(_interactionModeController, 'Mode d\'interaction préféré'),
              ],
            ),
          ),
          const SizedBox(height: 32),
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
              onPressed: () {
                final updatedProche = Proche(
                  name: _nameController.text,
                  relationship: _relationshipController.text,
                  distance: _distanceController.text,
                  favoriteActivities:
                      _favoriteActivitiesController.text.split(',').map((e) => e.trim()).toList(),
                  interactionMode: _interactionModeController.text,
                  imageName: widget.proche.imageName,
                );
                widget.onProcheUpdated(updatedProche);
                Navigator.pop(context); 
              },
              child: const Text(
                'Enregistrer',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
 Widget _buildProcheAvatar(Proche proche) {

    final imagePath = 'images/${proche.imageName}'; 

    return Center( 
    child: ClipOval(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4, 
        height: MediaQuery.of(context).size.width / 4, 
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.person, size: 50,);
          },
        ),
      ),
    ),
  );
  }
}