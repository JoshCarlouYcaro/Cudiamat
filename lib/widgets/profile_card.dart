import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFFF2A85), width: 1.5), // Pink Border
      ),
      elevation: 4,
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFF2A85),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          "John Paul Cudiamat",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          "BSIT - NIS \nAndroid Device",
          style: TextStyle(color: Colors.white70),
        ),
        isThreeLine: true,
      ),
    );
  }
}