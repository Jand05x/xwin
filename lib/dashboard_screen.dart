import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
        backgroundColor: Colors.white,
        
      

      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(   // Changed to ListView so page scrolls if long
          children: [

            // -----------------------
            // Stats Section
            // -----------------------
            Row(
              children: [
                Expanded(
                  child: _statCard("12", "Donations"),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: _statCard("240", "Points"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // -----------------------
            // Quick Actions (Your original ones)
            // -----------------------
            _quickAction(
              icon: Icons.bloodtype,
              text: "Find Blood Requests",
              onTap: () => Navigator.pushNamed(context, "/requests"),
            ),

            _quickAction(
              icon: Icons.event,
              text: "Upcoming Events",
              onTap: () => Navigator.pushNamed(context, "/events"),
            ),

            _quickAction(
              icon: Icons.check_circle,
              text: "Check Eligibility",
              onTap: () {
                // Show eligibility info
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Eligibility Requirements"),
                    content: Text(
                        "To donate blood, you must:\n\n"
                            "✓ Be 18-65 years old\n"
                            "✓ Weigh at least 50 kg\n"
                            "✓ Be in good health\n"
                            "✓ Not have donated in last 3 months\n"
                            "✓ Not have cold/flu\n"
                    ),
                    actions: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            // -----------------------
            // NEW ROUTES ADDED
            // -----------------------
            Text(
              "More Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            _quickAction(
              icon: Icons.local_hospital,
              text: "Hospital Dashboard",
              onTap: () => Navigator.pushNamed(context, "/hospital_dashboard"),
            ),

            _quickAction(
              icon: Icons.verified_user,
              text: "Verification Queue",
              onTap: () => Navigator.pushNamed(context, "/verify"),
            ),

            _quickAction(
              icon: Icons.menu_book,
              text: "Learn About Donation",
              onTap: () => Navigator.pushNamed(context, "/learn"),
            ),

            SizedBox(height: 25),

            // -----------------------
            // Notifications
            // -----------------------
            Text(
              "Recent Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text("Urgent: O+ needed nearby"),
              subtitle: Text("2 hours ago"),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------
  // Widgets
  // -----------------------

  Widget _statCard(String value, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget _quickAction({required IconData icon, required String text, required Function onTap}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => onTap(),
      ),
    );
  }
}
