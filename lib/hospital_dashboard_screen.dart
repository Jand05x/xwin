// Hospital management dashboard for posting requests and managing events
import 'package:flutter/material.dart';
import 'post_blood_request_screen.dart';
import 'view_donors_screen.dart';
import 'create_event_screen.dart';

// StatelessWidget because dashboard displays static buttons
class HospitalDashboardScreen extends StatelessWidget {
  const HospitalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Hospital Dashboard"),
        backgroundColor: Colors.amber[700],
      ),

      body: Padding(
        padding: EdgeInsets.all(16), // Space around content

        child: ListView(
          // Scrollable content
          children: [
            // Statistics cards showing key metrics
            Row(
              children: [
                // Active blood requests count
                Expanded(
                  child: _buildStatCard(
                    "8",
                    "Active Requests",
                    Colors.red,
                    Icons.bloodtype,
                  ),
                ),
                SizedBox(width: 15),
                // Planned events count
                Expanded(
                  child: _buildStatCard(
                    "3",
                    "Events Planned",
                    Colors.blue,
                    Icons.event,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Section title
            Text(
              "Hospital Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            // Button to create new blood request
            _actionButton(
              "Post Blood Request",
              Colors.red,
              Icons.bloodtype,
              () {
                // Navigate to blood request creation screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostBloodRequestScreen(),
                  ),
                );
              },
            ),

            // Button to create new donation event
            _actionButton("Create Event", Colors.blue, Icons.event, () {
              // Navigate to event creation screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventScreen()),
              );
            }),

            // Button to view registered donors
            _actionButton("View Donors", Colors.orange, Icons.people, () {
              // Navigate to donors list screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewDonorsScreen()),
              );
            }),

            SizedBox(height: 24),

            // Recent activity section
            Text(
              "Recent Activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text("5 donors responded to O+ request"),
                      subtitle: Text("2 hours ago"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.event_available, color: Colors.blue),
                      title: Text("Blood drive scheduled for Dec 10"),
                      subtitle: Text("5 hours ago"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.warning, color: Colors.orange),
                      title: Text("B- Blood inventory low"),
                      subtitle: Text("1 day ago"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Creates a statistics card with better visibility
  Widget _buildStatCard(
    String number,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          // Large number display
          Text(
            number,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          // Label below number
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Creates a full-width action button with better styling
  Widget _actionButton(
    String label,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          icon: Icon(icon, size: 24),
          label: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
