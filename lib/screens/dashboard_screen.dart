import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/profile_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/dashboard_tile.dart';
import 'registration_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _apiService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LPU Student Info App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2196F3), // Light Blue AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegistrationScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            const ProfileCard(),
            const SizedBox(height: 20),

            // Week 3 Requirement: Dashboard Cards (Students, Programs, Campus)
            const Text(
              "LPU Campus Overview",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF2A85),
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
              children: const [
                KpiCard(title: "Students", status: "1,250 Active", icon: Icons.people),
                KpiCard(title: "Programs", status: "12 Courses", icon: Icons.school),
                KpiCard(title: "Campus", status: "LPU Cavite", icon: Icons.location_city),
              ],
            ),
            const SizedBox(height: 20),

            // System Status KPIs
            const Text(
              "System Status (KPIs)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF2A85),
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.1,
              children: const [
                KpiCard(title: "Network", status: "Online", icon: Icons.wifi),
                KpiCard(title: "GPS", status: "Active", icon: Icons.gps_fixed),
                KpiCard(title: "API", status: "Connected", icon: Icons.cloud_done),
                KpiCard(title: "Storage", status: "64% Used", icon: Icons.storage),
              ],
            ),
            const SizedBox(height: 20),

            // Quick Action Tiles with Registration Navigation
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF2A85),
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    );
                  },
                  child: const DashboardTile(title: "Register Student", icon: Icons.app_registration),
                ),
                const DashboardTile(title: "Device Info", icon: Icons.phone_android),
                const DashboardTile(title: "API Status", icon: Icons.api),
                const DashboardTile(title: "Network Monitor", icon: Icons.network_check),
              ],
            ),
          ],
        ),
      ),
    );
  }
}