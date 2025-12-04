// Main home screen showing donor statistics and quick actions
import 'package:flutter/material.dart';

// StatelessWidget because screen doesn't need to track state changes
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        actions: [
          // Notifications bell icon
          IconButton(
            icon: Icon(Icons.notifications, size: 28),
            onPressed: () => Navigator.pushNamed(context, "/notifications"),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16), // Space around content

        child: ListView(
          // Scrollable list of widgets
          children: [
            // Welcome message with username
            Text(
              "Welcome, User",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Statistics section showing user's donation stats
            Row(
              children: [
                // Donations count card
                Expanded(child: _statCard("12", "Your Donations")),
                SizedBox(width: 15), // Space between cards
                // Points count card
                Expanded(child: _statCard("240", "Your Points")),
              ],
            ),

            SizedBox(height: 20),

            // Quick action buttons for main features

            // Button to view blood requests
            _quickAction(
              icon: Icons.bloodtype,
              text: "Find Blood Requests",
              onTap: () => Navigator.pushNamed(context, "/requests"),
            ),

            // Button to view donation events
            _quickAction(
              icon: Icons.event,
              text: "Events",
              onTap: () => Navigator.pushNamed(context, "/events"),
            ),

            // Button to check if user is eligible to donate
            _quickAction(
              icon: Icons.check_circle,
              text: "Check Eligibility",
              onTap: () {
                // Show dialog with eligibility requirements
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
                      "✓ Pass a blood test to confirm health\n"
                      "✓ After passing the blood test, you can donate\n",
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

            // Additional options section
            Text(
              "More Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Button to hospital management dashboard
            _quickAction(
              icon: Icons.local_hospital,
              text: "Hospital Dashboard",
              onTap: () => Navigator.pushNamed(context, "/hospital_dashboard"),
            ),

            // Button to admin dashboard
            _quickAction(
              icon: Icons.admin_panel_settings,
              text: "Admin Dashboard",
              onTap: () => Navigator.pushNamed(context, "/admin_dashboard"),
            ),

            // Button to educational articles
            _quickAction(
              icon: Icons.menu_book,
              text: "Learn About Donation",
              onTap: () => Navigator.pushNamed(context, "/learn"),
            ),

            SizedBox(height: 25),

            // Notifications section
            Text(
              "Recent Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Sample notification
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

  // Reusable widget functions

  // Creates a statistics card with number and label
  Widget _statCard(String value, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100], // Light green background
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Column(
        children: [
          // Large number display
          Text(
            value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          // Label below number
          Text(label),
        ],
      ),
    );
  }

  // Creates a clickable action card with icon and text
  Widget _quickAction({
    required IconData icon,
    required String text,
    required Function onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.red), // Icon on left
        title: Text(text), // Action text
        trailing: Icon(Icons.arrow_forward_ios, size: 16), // Arrow on right
        onTap: () => onTap(), // Execute action when tapped
      ),
    );
  }
}
