// Admin management dashboard for system oversight
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ADDED: Required for Logout
import 'error_widgets.dart'; 

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        // --- LOGOUT BUTTON START ---
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // No need to navigate manually; your AuthWrapper 
              // in main.dart will handle the switch to WelcomeScreen
            },
          ),
        ],
        // --- LOGOUT BUTTON END ---
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donors').snapshots(),
        builder: (context, donorSnapshot) {
          
          if (donorSnapshot.hasError) {
            return AppErrorWidget(
              message: "System sync failed. Could not retrieve donor registry.",
              onRetry: () => setState(() {}),
            );
          }

          if (donorSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.deepPurple),
                  SizedBox(height: 16),
                  Text("Initializing Admin Console..."),
                ],
              ),
            );
          }

          int totalDonors = donorSnapshot.data?.docs.length ?? 0;
          int pendingDonors = donorSnapshot.data?.docs
                  .where((doc) => (doc.data() as Map<String, dynamic>)['status'] == 'pending')
                  .length ?? 0;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        "$pendingDonors",
                        "Pending Donors",
                        Colors.orange,
                        Icons.people,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
                        builder: (context, hospSnap) {
                          int hospCount = hospSnap.data?.docs.length ?? 0;
                          return _statCard(
                            "$hospCount",
                            "Hospitals",
                            Colors.blue,
                            Icons.local_hospital,
                          );
                        }
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  "Verification Queue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                _adminButton(
                  label: "Verify Donor Identities",
                  color: Colors.orange,
                  icon: Icons.verified_user,
                  onTap: () => Navigator.pushNamed(context, "/verify"),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Infrastructure",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                _adminButton(
                  label: "Manage Hospital Access",
                  color: Colors.blue,
                  icon: Icons.business,
                  onTap: () => _showHospitalManagement(context),
                ),

                const SizedBox(height: 8),

                _adminButton(
                  label: "System Reports & Logs",
                  color: Colors.purple,
                  icon: Icons.bar_chart,
                  onTap: () => _showSystemStats(context, totalDonors),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _adminButton({required String label, required Color color, required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          icon: Icon(icon, size: 24),
          label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }

  void _showHospitalManagement(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hospital Management"),
        content: const Text("Live hospital verification queue will appear here."),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }

  void _showSystemStats(BuildContext context, int donors) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("System Statistics"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text("Total Registered Donors"), trailing: Text("$donors")),
            const ListTile(title: Text("Active Blood Requests"), trailing: Text("24")),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }
}