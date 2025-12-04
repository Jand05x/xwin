// Screen showing upcoming blood donation events
import 'package:flutter/material.dart';

// StatelessWidget because event list is static (in real app would be dynamic)
class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Donation Events"),
      ),

      body: ListView(  // Scrollable list of events
        padding: EdgeInsets.all(16),  // Space around content

        children: [
          // Section title
          Text(
            "Upcoming Events",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 15),

          // Sample event cards (in real app, these would come from database)
          _eventCard(
            title: "Community Blood Drive",
            date: "Nov 15, 2025 - 8:00 AM",
            location: "Shiryan Medical Center",
          ),
          _eventCard(
            title: "Health Awareness Day",
            date: "Nov 22, 2025 - 10:00 AM",
            location: "KRO street",
          ),
        ],
      ),
    );
  }

  // Reusable widget to create an event card
  Widget _eventCard({
    required String title,
    required String date,
    required String location,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),  // Space inside card

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Align text to left

          children: [
            // Event name (title)
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            // Event date and time
            Text(date),

            SizedBox(height: 5),

            // Event location
            Text(location),

            SizedBox(height: 10),

            // RSVP button to register for event
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("RSVP"),
              onPressed: () {},  // TODO: Add RSVP functionality
            )
          ],
        ),
      ),
    );
  }
}