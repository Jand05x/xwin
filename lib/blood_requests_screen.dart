// Screen displaying list of blood requests from hospitals
import 'package:flutter/material.dart';

// StatelessWidget because request list is static (in real app would be dynamic from database)
class BloodRequestsScreen extends StatelessWidget {
  const BloodRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Blood Requests",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),

      body: ListView(
        // Scrollable list of blood requests
        padding: EdgeInsets.all(16), // Space around content

        children: [
          // Sample blood request cards (in real app, these would come from database)
          _requestCard(
            "A+ Blood Needed",
            "Central Hospital",
            "Urgent - 2 units",
            Colors.red,
          ),
          _requestCard(
            "O- Blood Needed",
            "City Medical Center",
            "Within 24 hrs - 3 units",
            Colors.purple,
          ),
          _requestCard(
            "B- Blood Needed",
            "Regional Hospital",
            "Scheduled - 1 unit",
            Colors.orange,
          ),
        ],
      ),
    );
  }

  // Reusable widget to create a blood request card
  Widget _requestCard(
    String title,
    String location,
    String urgency,
    Color color,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(16), // Space inside card

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to left

          children: [
            // Blood type needed (title)
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.bloodtype, color: color, size: 24),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Hospital name (location)
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(location, style: TextStyle(color: Colors.grey[700])),
              ],
            ),

            SizedBox(height: 8),

            // Urgency level
            Row(
              children: [
                Icon(Icons.warning, size: 16, color: color),
                SizedBox(width: 8),
                Text(
                  urgency,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Donate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Donate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {}, // TODO: Add response functionality
              ),
            ),
          ],
        ),
      ),
    );
  }
}
