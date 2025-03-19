import 'package:flutter/material.dart';
import 'relations.dart';

class AddRelation extends StatefulWidget {
  const AddRelation({Key? key}) : super(key: key);

  @override
  _AddRelationState createState() => _AddRelationState();
}

class _AddRelationState extends State<AddRelation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _favoriteActivitiesController = TextEditingController();
  final TextEditingController _interactionModeController = TextEditingController();

  void _saveProche() {
    if (_nameController.text.isEmpty || _relationshipController.text.isEmpty) {
      return;
    }

    final newProche = Proche(
      name: _nameController.text,
      relationship: _relationshipController.text,
      distance: _distanceController.text,
      favoriteActivities: _favoriteActivitiesController.text.split(',').map((e) => e.trim()).toList(),
      interactionMode: _interactionModeController.text,
      imageName:'image.png',
    );

    Navigator.pop(context, newProche);
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
      appBar: AppBar(
        title: const Text('Ajouter un proche'),
        backgroundColor: const Color(0xFFF6F2ED),
      ),
      body: Container(
        color: const Color(0xFFF6F2ED), // Fond beige
        padding: const EdgeInsets.all(16.0),
        child : Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildTextField(_nameController, 'Nom'),
                  const SizedBox(height: 12),
                  _buildTextField(_relationshipController, 'Relation'),
                  const SizedBox(height: 12),
                  _buildTextField(_distanceController, 'Distance'),
                  const SizedBox(height: 12),
                  _buildTextField(_favoriteActivitiesController, 'Activités préférées'),
                  const SizedBox(height: 12),
                  _buildTextField(_interactionModeController, 'Mode d\'interaction'),
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
                    onPressed: _saveProche,
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
}

