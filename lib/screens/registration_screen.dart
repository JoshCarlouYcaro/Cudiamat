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
  // Required fields controllers
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();

  // Optional fields controllers (Ayon sa PDF Part 3)[cite: 5]
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();

  // Dropdown value para sa Program
  String? _selectedProgram;
  final List<String> _programs = ['BSIT', 'BSCS', 'BSCpE', 'BSIS'];

  // Dropdown value para sa Year Level (Idinagdag)
  String? _selectedYearLevel;
  final List<String> _yearLevels = ['1st Year', '2nd Year', '3rd Year', '4th Year'];

  // Function para mag-export ng text file sa phone storage (Exercise 6 format)[cite: 11]
  Future<void> _saveStudentFile(
      String name,
      String id,
      String program,
      String year,
      String email,
      String contact,
      String address,
      ) async {
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
Contact Number: $contact
Address: $address
""";

      await file.writeAsString(content);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File saved successfully to: ${file.path}"),
          backgroundColor: const Color(0xFFFF2A85),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving file: $e"), backgroundColor: Colors.red),
      );
    }
  }

  void _submitForm() {
    // 1. Check kung may blankong fields o walang napiling program/year level
    if (_nameController.text.isEmpty ||
        _idController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _selectedProgram == null ||
        _selectedYearLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all required fields, program, and year level!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 2. Conditional: Student ID ay dapat puro numbers lang
    final idRegExp = RegExp(r'^[0-9]+$');
    if (!idRegExp.hasMatch(_idController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Student ID must contain numbers only!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 3. Conditional: Email ay dapat may '@'
    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address containing '@'!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 4. Conditional: Contact Number (kung nilagyan) ay dapat puro numbers at eksaktong 11 digits
    if (_contactController.text.isNotEmpty) {
      if (!idRegExp.hasMatch(_contactController.text) || _contactController.text.length != 11) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Contact number must be exactly 11 digits and numbers only!"),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
    }

    // Kung pasado lahat ng validations, i-save at i-navigate ang data
    _saveStudentFile(
      _nameController.text,
      _idController.text,
      _selectedProgram!,
      _selectedYearLevel!,
      _emailController.text,
      _contactController.text,
      _addressController.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          studentName: _nameController.text,
          studentId: _idController.text,
          email: _emailController.text,
          program: _selectedProgram!,
          yearLevel: _selectedYearLevel!,
          contactNumber: _contactController.text,
          address: _addressController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Registration",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2196F3),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Student Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF2A85)),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Student Name *", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Student ID (Numbers only) *", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email Address (Must have '@') *", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            // DropdownButton para sa Program[cite: 5]
            DropdownButtonFormField<String>(
              value: _selectedProgram,
              decoration: const InputDecoration(labelText: "Program *", border: OutlineInputBorder()),
              items: _programs.map((String program) {
                return DropdownMenuItem<String>(
                  value: program,
                  child: Text(program),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProgram = newValue;
                });
              },
            ),
            const SizedBox(height: 12),
            // DropdownButton para sa Year Level (Idinagdag)
            DropdownButtonFormField<String>(
              value: _selectedYearLevel,
              decoration: const InputDecoration(labelText: "Year Level *", border: OutlineInputBorder()),
              items: _yearLevels.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYearLevel = newValue;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactController,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              decoration: const InputDecoration(
                labelText: "Contact Number (11 digits, Optional)",
                border: OutlineInputBorder(),
                counterText: "",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Address (Optional)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF2A85),
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