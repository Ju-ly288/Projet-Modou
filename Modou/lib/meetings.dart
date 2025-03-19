import 'package:flutter/material.dart';
import 'package:modou/app_layout.dart';

class MeetingsPage extends StatefulWidget {
  const MeetingsPage({super.key});

  @override
  _MeetingsPageState createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
  bool isReady = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED),
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Messages',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Positioned(
                      top: -13, 
                      right: -7,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '6',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Image.asset(
                  'images/ppmessages.png',
                  width: 150, 
                  height: 150,
                ),
              ],
            ),
          
            const Text(
              'Rencontre',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Envie de nouvelles connexions ? Modou est là pour vous présenter des gens géniaux.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Switch(
                  value: isReady,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      isReady = value;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: isReady ? 'Vous êtes prêt(e) à rencontrer !\n' : 'Vous êtes timide, pour l’instant...\n',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: isReady ? 'Votre profil est visible par les autres.' : 'Votre profil n’est pas visible par les autres.',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Clique juste en dessous pour rencontrer des passionnés comme toi.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Assure-toi d’avoir bien complété tes paramètres.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildButton(Icons.favorite, 'Obtenir un profil selon vos centres d\'intérêts'),
            const SizedBox(height: 20),
            const Text(
              'Ou laisse le hasard te surprendre !',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            this._buildButton(Icons.casino, 'Obtenir un profil au hasard'),
          ],
        ),
        ),
      
      
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
Widget _buildButton(IconData icon, String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED),
      appBar: AppBar(
        title: const Text('Modou', style: TextStyle(fontFamily: 'Pacifico', fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.notifications, color: Colors.black),
        actions: const [Icon(Icons.person, color: Colors.black)],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.teal[100],
                child: Image.asset('images/image.png', fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              const Text('Pauline (25 ans)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description profil', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Passionnée de cinéma et d’écriture, aimerait organiser une rencontre pour échanger des idées.')
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Suggestions messages', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              const BulletText('Salut Pauline ! J’ai vu que tu aimais le cinéma. As-tu vu le dernier film de Nolan ?'),
              const BulletText('Coucou Pauline ! Je viens de voir une expo sur l’histoire du cinéma à la médiathèque. Tu serais partante pour y faire un tour ?'),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Message...',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;
  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16)),
        Expanded(child: Text(text)),
      ],
    );
  }
}
