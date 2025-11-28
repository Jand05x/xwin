import 'package:flutter/material.dart';

class BloodRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Blood Requests"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _requestCard("A+ Blood Needed", "Central Hospital", "Urgent - 2 units"),
          _requestCard("O- Blood Needed", "City Medical Center", "Within 24 hrs - 3 units"),
          _requestCard("B- Blood Needed", "Regional Hospital", "Scheduled - 1 unit"),
        ],
      ),
    );
  }

  Widget _requestCard(String title, String location, String urgency) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(location),
            SizedBox(height: 5),
            Text(urgency, style: TextStyle(color: Colors.red)),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Respond"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
