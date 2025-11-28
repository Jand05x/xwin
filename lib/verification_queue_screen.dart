import 'package:flutter/material.dart';

class VerificationQueueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Queue"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "12 Pending Verifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            _buildVerificationCard(),

            SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {},
                child: Text("Next Application →"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Jand Ayoub",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            Text("Blood Type: A+"),
            Text("Submitted: Oct 28, 2025"),

            SizedBox(height: 12),

            Text("• ID: verified_id.jpg"),
            Text("• Selfie: selfie.jpg"),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Approve"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Reject"),
                ),
              ],
            ),

            SizedBox(height: 10),

            Center(
              child: TextButton(
                onPressed: () {},
                child: Text("View Documents"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
