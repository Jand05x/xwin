import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Donation Events"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),

          _eventCard(
            title: "Community Blood Drive",
            date: "Nov 15, 2025 - 8:00 AM",
            location: "Duhok Medical Center",
          ),
          _eventCard(
            title: "Health Awareness Day",
            date: "Nov 22, 2025 - 10:00 AM",
            location: "City Square",
          ),
        ],
      ),
    );
  }

  Widget _eventCard({required String title, required String date, required String location}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(date),
            SizedBox(height: 5),
            Text(location),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("RSVP"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
