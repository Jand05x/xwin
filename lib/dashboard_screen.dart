import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, size: 28),
            onPressed: () => Navigator.pushNamed(context, "/notifications"),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('donors').doc(user?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Something went wrong"));
          
          // Default values while loading or if data is missing
          String name = "User";
          String donations = "0";
          String points = "0";

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            name = data['name'] ?? "User";
            donations = (data['totalDonations'] ?? 0).toString();
            points = (data['points'] ?? 0).toString();
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  "Welcome, $name",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _statCard(donations, "Your Donations")),
                    const SizedBox(width: 15),
                    Expanded(child: _statCard(points, "Your Points")),
                  ],
                ),
                const SizedBox(height: 20),
                _quickAction(
                  icon: Icons.bloodtype,
                  text: "Find Blood Requests",
                  onTap: () => Navigator.pushNamed(context, "/requests"),
                ),
                _quickAction(
                  icon: Icons.event,
                  text: "Events",
                  onTap: () => Navigator.pushNamed(context, "/events"),
                ),
                _quickAction(
                  icon: Icons.check_circle,
                  text: "Check Eligibility",
                  onTap: () => _showEligibility(context),
                ),
                const SizedBox(height: 20),
                const Text("Quick Links", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _quickAction(
                  icon: Icons.local_hospital,
                  text: "Hospital Dashboard",
                  onTap: () => Navigator.pushNamed(context, "/hospital_dashboard"),
                ),
                _quickAction(
                  icon: Icons.admin_panel_settings,
                  text: "Admin Dashboard",
                  onTap: () => Navigator.pushNamed(context, "/admin_dashboard"),
                ),
                const SizedBox(height: 25),
                const Text("Recent Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                
                // Real-time Recent Notifications Stream
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notifications')
                      .limit(3)
                      .snapshots(),
                  builder: (context, noteSnap) {
                    if (!noteSnap.hasData || noteSnap.data!.docs.isEmpty) {
                      return const Text("No recent notifications", style: TextStyle(color: Colors.grey));
                    }
                    return Column(
                      children: noteSnap.data!.docs.map((doc) {
                        final note = doc.data() as Map<String, dynamic>;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.info_outline, color: Colors.red),
                          title: Text(note['title'] ?? "Update"),
                          subtitle: Text(note['message'] ?? ""),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEligibility(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eligibility Requirements"),
        content: const Text(
          "✓ Be 18-65 years old\n"
          "✓ Weigh at least 50 kg\n"
          "✓ Pass health screenings\n"
          "✓ No donations in last 3 months",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _quickAction({required IconData icon, required String text, required Function onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () => onTap(),
      ),
    );
  }
}