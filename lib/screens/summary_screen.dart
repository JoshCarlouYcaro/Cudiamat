import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final String studentName;
  final String studentId;
  final String email;
  final String program;
  final String yearLevel;
  final String contactNumber; // Idinagdag para sa contact number
  final String address;       // Idinagdag para sa address

  const SummaryScreen({
    super.key,
    required this.studentName,
    required this.studentId,
    required this.email,
    required this.program,
    required this.yearLevel,
    required this.contactNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Summary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2196F3),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Submitted Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF2A85))),
            const SizedBox(height: 15),

            // Student Name Card
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Student Name", style: TextStyle(color: Colors.white60)),
                subtitle: Text(studentName, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Student ID Card
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Student ID", style: TextStyle(color: Colors.white60)),
                subtitle: Text(studentId, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Email Address Card
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Email Address", style: TextStyle(color: Colors.white60)),
                subtitle: Text(email, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Program Card (Ayon sa Exercise 4 ng PDF)[cite: 6]
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Program", style: TextStyle(color: Colors.white60)),
                subtitle: Text(program, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Year Level Card
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Year Level", style: TextStyle(color: Colors.white60)),
                subtitle: Text(yearLevel, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Contact Number Card (Idinagdag)
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Contact Number", style: TextStyle(color: Colors.white60)),
                subtitle: Text(
                  contactNumber.isEmpty ? "N/A" : contactNumber,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Address Card (Idinagdag)
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                title: const Text("Address", style: TextStyle(color: Colors.white60)),
                subtitle: Text(
                  address.isEmpty ? "N/A" : address,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF2A85)),
              onPressed: () {
                Navigator.pop(context); // Bumalik sa Registration o Dashboard
              },
              child: const Text("Back to Dashboard", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}