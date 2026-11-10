import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'summary_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _programController = TextEditingController();
  final _yearController = TextEditingController();

  // Function para mag-export ng text file sa phone storage
  Future<void> _saveStudentFile(String name, String id, String program, String year, String email) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/student_info.txt');

      String content = """
STUDENT INFORMATION
-------------------
Name: $name
ID: $id
Program: $program
Year: $year
Email: $email
""";

      await file.writeAsString(content);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File saved successfully to: ${file.path}"), backgroundColor: const Color(0xFFFF2A85)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving file: $e"), backgroundColor: Colors.red),
      );
    }
  }

  void _submitForm() {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields!"), backgroundColor: Colors.redAccent),
      );
      return;
    }

    // I-save ang file at mag-navigate patungong Summary Page habang ipinapasa ang data
    _saveStudentFile(
      _nameController.text,
      _idController.text,
      _programController.text,
      _yearController.text,
      _emailController.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          studentName: _nameController.text,
          studentId: _idController.text,
          email: _emailController.text,
          program: _programController.text,
          yearLevel: _yearController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2196F3), // Light Blue AppBar
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter Student Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF2A85))),
            const SizedBox(height: 15),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Student Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: "Student ID", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email Address", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _programController,
              decoration: const InputDecoration(labelText: "Program (e.g., BSIT)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: "Year Level", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF2A85), // Pink Button
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _submitForm,
                child: const Text("Save & Generate Summary", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}