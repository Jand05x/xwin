// Screen showing upcoming blood donation events
import 'package:flutter/material.dart';

// StatelessWidget because event list is static (in real app would be dynamic)
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Donation Events",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),

      body: ListView(
        // Scrollable list of events
        padding: EdgeInsets.all(16), // Space around content

        children: [
          // Section title
          Text(
            "Upcoming Events",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 15),

          // Sample event cards (in real app, these would come from database)
          _eventCard(
            title: "Community Blood Drive",
            date: "Nov 15, 2025 - 8:00 AM",
            location: "Shiryan Medical Center",
            attendees: 45,
          ),
          _eventCard(
            title: "Health Awareness Day",
            date: "Nov 22, 2025 - 10:00 AM",
            location: "KRO street",
            attendees: 32,
          ),
          _eventCard(
            title: "Hospital Donation Campaign",
            date: "Dec 5, 2025 - 9:00 AM",
            location: "Central Hospital",
            attendees: 28,
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
    required int attendees,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(16), // Space inside card

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to left

          children: [
            // Event name (title)
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            // Event date and time
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue, size: 16),
                SizedBox(width: 8),
                Text(date, style: TextStyle(color: Colors.grey[700])),
              ],
            ),

            SizedBox(height: 8),

            // Event location
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            // Attendees
            Row(
              children: [
                Icon(Icons.people, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Text(
                  "$attendees RSVPs",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // RSVP button to register for event
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "RSVP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {}, // TODO: Add RSVP functionality
              ),
            ),
          ],
        ),
      ),
    );
  }
}
