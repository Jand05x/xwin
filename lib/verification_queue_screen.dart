// Admin screen for verifying new donor applications
import 'package:flutter/material.dart';

// StatelessWidget because verification cards are static (in real app would be dynamic)
class VerificationQueueScreen extends StatelessWidget {
  const VerificationQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Verification Queue"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(16), // Space around content

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to left

          children: [
            // Shows total pending verifications
            Text(
              "12 Pending Verifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Display verification card for current application
            _buildVerificationCard(),

            SizedBox(height: 20),

            // Button to move to next application
            Center(
              child: TextButton(
                onPressed: () {}, // TODO: Load next application
                child: Text("Next Application →"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Creates a card showing donor application details
  Widget _buildVerificationCard() {
    return Card(
      elevation: 4, // Shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),

      child: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Applicant name
            Text(
              "Jand Ayoub",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            // Applicant blood type
            Text("Blood Type: A+"),

            // Submission date
            Text("Submitted: Oct 28, 2025"),

            SizedBox(height: 12),

            // List of uploaded documents
            Text("• ID: verified_id.jpg"),
            Text("• Selfie: selfie.jpg"),

            SizedBox(height: 20),

            // Action buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Approve button - verifies donor
                ElevatedButton(
                  onPressed: () {}, // TODO: Approve applicant
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Approve"),
                ),

                // Reject button - denies application
                ElevatedButton(
                  onPressed: () {}, // TODO: Reject applicant
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Reject"),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Button to view uploaded documents
            Center(
              child: TextButton(
                onPressed: () {}, // TODO: Open document viewer
                child: Text("View Documents"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
