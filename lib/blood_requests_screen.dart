// Screen displaying list of blood requests from hospitals
import 'package:flutter/material.dart';

// StatelessWidget because request list is static (in real app would be dynamic from database)
class BloodRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Blood Requests"),
      ),

      body: ListView(  // Scrollable list of blood requests
        padding: EdgeInsets.all(16),  // Space around content

        children: [
          // Sample blood request cards (in real app, these would come from database)
          _requestCard(
            "A+ Blood Needed",
            "Central Hospital",
            "Urgent - 2 units",
          ),
          _requestCard(
            "O- Blood Needed",
            "City Medical Center",
            "Within 24 hrs - 3 units",
          ),
          _requestCard(
            "B- Blood Needed",
            "Regional Hospital",
            "Scheduled - 1 unit",
          ),
        ],
      ),
    );
  }

  // Reusable widget to create a blood request card
  Widget _requestCard(String title, String location, String urgency) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),  // Space inside card

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Align text to left

          children: [
            // Blood type needed (title)
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            // Hospital name (location)
            Text(location),

            SizedBox(height: 5),

            // Urgency level (displayed in red)
            Text(urgency, style: TextStyle(color: Colors.red)),

            SizedBox(height: 10),

            // Respond button aligned to right
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Respond"),
                onPressed: () {},  // TODO: Add response functionality
              ),
            )
          ],
        ),
      ),
    );
  }
}