import 'package:flutter/material.dart';
import 'post_blood_request_screen.dart';  // ADD THIS
import 'view_donors_screen.dart';         // ADD THIS
import 'create_event_screen.dart';        // ADD THIS

class HospitalDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Dashboard"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("8", "Active Requests", Colors.green),
                _buildStatCard("3", "Events Planned", Colors.blue),
              ],
            ),

            SizedBox(height: 20),

            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // NOW THESE BUTTONS WORK!
            _actionButton("Post Blood Request", Colors.red, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostBloodRequestScreen()),
              );
            }),

            _actionButton("Create Event", Colors.blue, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventScreen()),
              );
            }),

            SizedBox(height: 8),

            _actionButton("View Donors", Colors.orange, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewDonorsScreen()),
              );
            }),

            SizedBox(height: 24),
            Text(
              "Recent Activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text("5 donors responded to O+ request"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 6),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color color, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),

      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(label, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}