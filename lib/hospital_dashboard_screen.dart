// Hospital management dashboard for posting requests and managing events
import 'package:flutter/material.dart';
import 'post_blood_request_screen.dart';
import 'view_donors_screen.dart';
import 'create_event_screen.dart';

// StatelessWidget because dashboard displays static buttons
class HospitalDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Hospital Dashboard"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),  // Space around content

        child: ListView(  // Scrollable content
          children: [
            // Statistics cards showing key metrics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Active blood requests count
                _buildStatCard("8", "Active Requests", Colors.green),

                // Planned events count
                _buildStatCard("3", "Events Planned", Colors.blue),
              ],
            ),

            SizedBox(height: 20),

            // Section title
            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            // Button to create new blood request
            _actionButton("Post Blood Request", Colors.red, () {
              // Navigate to blood request creation screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostBloodRequestScreen()),
              );
            }),

            // Button to create new donation event
            _actionButton("Create Event", Colors.blue, () {
              // Navigate to event creation screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventScreen()),
              );
            }),

            SizedBox(height: 8),

            // Button to view registered donors
            _actionButton("View Donors", Colors.orange, () {
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

            // Sample activity log
            Text("5 donors responded to O+ request"),
          ],
        ),
      ),
    );
  }

  // Creates a statistics card with number, label, and color
  Widget _buildStatCard(String number, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 10),  // Space between cards
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),  // Light colored background
          borderRadius: BorderRadius.circular(12),  // Rounded corners
          border: Border.all(color: color, width: 2),  // Colored border
        ),
        child: Column(
          children: [
            // Large number display
            Text(
              number,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 6),
            // Label below number
            Text(label),
          ],
        ),
      ),
    );
  }

  // Creates a full-width action button
  Widget _actionButton(String label, Color color, VoidCallback onTap) {
    return Container(
      width: double.infinity,  // Full width
      margin: EdgeInsets.only(bottom: 12),  // Space below button

      child: ElevatedButton(
        onPressed: onTap,  // Execute action when pressed
        style: ElevatedButton.styleFrom(
          backgroundColor: color,  // Button color
          padding: EdgeInsets.symmetric(vertical: 14),  // Button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),  // Rounded corners
          ),
        ),
        child: Text(label, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}