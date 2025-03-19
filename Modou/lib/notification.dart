import 'package:flutter/material.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  //exemples ficitifs de notifications
  final List<Map<String, dynamic>> notifications = [
    {
      "icon": Icons.notifications_active,
      "color": Colors.blue,
      "title": "Nouveau message",
      "content": "Pierre vous a envoyé un message.",
      "time": "Il y a 2 min"
    },
    {
      "icon": Icons.event,
      "color": Colors.green,
      "title": "Rappel : Rencontre prévue",
      "content": "Rencontre avec Sophie demain à 14h.",
      "time": "Il y a 1 heure"
    },
    {
      "icon": Icons.phone,
      "color": Colors.orange,
      "title": "Rappel d'appel",
      "content": "Vous n'avez pas appelé votre frère depuis 1 semaine.",
      "time": "Hier"
    },
    {
      "icon": Icons.cake,
      "color": Colors.purple,
      "title": "Anniversaire",
      "content": "C'est l'anniversaire de Laura aujourd'hui ! 🎉",
      "time": "Aujourd'hui"
    },
    {
      "icon": Icons.group,
      "color": Colors.red,
      "title": "Nouvelle suggestion",
      "content": "Vous devriez recontacter Emma, cela fait longtemps !",
      "time": "Il y a 3 jours"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F2ED),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: notification["color"].withOpacity(0.2),
                        child: Icon(notification["icon"], color: notification["color"]),
                      ),
                      title: Text(notification["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(notification["content"]),
                      trailing: Text(notification["time"], style: const TextStyle(color: Colors.grey)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
