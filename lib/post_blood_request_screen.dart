// Screen where hospitals post new blood requests
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added for database integration

// StatefulWidget because we need to track form inputs and selections
class PostBloodRequestScreen extends StatefulWidget {
  const PostBloodRequestScreen({super.key});

  @override
  _PostBloodRequestScreenState createState() => _PostBloodRequestScreenState();
}

class _PostBloodRequestScreenState extends State<PostBloodRequestScreen> {
  // Controllers to get text from input fields
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Variables to store dropdown selections
  String? selectedBloodType;
  String? selectedUrgency;

  // Task: Properly dispose of controllers to prevent memory leaks
  @override
  void dispose() {
    unitsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text(
          "Post Blood Request",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        elevation: 4,
      ),

      body: SingleChildScrollView(
        // Makes form scrollable
        padding: EdgeInsets.all(20), // Space around form

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to left

          children: [
            // Form section title
            Icon(Icons.bloodtype, size: 40, color: Colors.red),
            SizedBox(height: 10),
            Text(
              "Request Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please provide information about the blood needed",
              style: TextStyle(color: Colors.grey[600]),
            ),

            SizedBox(height: 25),

            // Dropdown to select blood type needed
            DropdownButtonFormField<String>(
              value: selectedBloodType, // Changed from initialValue for better State control
              decoration: InputDecoration(
                labelText: "Blood Type Needed",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                prefixIcon: Icon(Icons.bloodtype, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[50],
              ),

              // List of blood type options
              items: [
                "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-",
              ].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),

              // Called when user selects an option
              onChanged: (v) {
                setState(() => selectedBloodType = v);
              },
            ),

            SizedBox(height: 20),

            // Input field for number of units needed
            TextField(
              controller: unitsController,
              keyboardType: TextInputType.number, // Show number keyboard
              decoration: InputDecoration(
                labelText: "Number of Units",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                prefixIcon: Icon(Icons.opacity, color: Colors.red),
                hintText: "e.g., 2", // Example text
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),

            SizedBox(height: 20),

            // Dropdown to select urgency level
            DropdownButtonFormField<String>(
              value: selectedUrgency,
              decoration: InputDecoration(
                labelText: "Urgency Level",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.warning, color: Colors.orange),
              ),

              // Urgency options
              items: [
                "Urgent",
                "Within 24 hours",
                "Scheduled",
              ].map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),

              // Called when user selects an option
              onChanged: (v) {
                setState(() => selectedUrgency = v);
              },
            ),

            SizedBox(height: 15),

            // Optional description field
            TextField(
              controller: descriptionController,
              maxLines: 4, // Multi-line text area
              decoration: InputDecoration(
                labelText: "Additional Details (Optional)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Patient condition, specific requirements...",
              ),
            ),

            SizedBox(height: 30),

            // Submit button
            SizedBox(
              width: double.infinity, // Full width
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitRequest, // Call validation and firebase function
                child: Text(
                  "Post Request",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Task: Validates form and submits blood request to Firestore
  Future<void> _submitRequest() async {
    // 1. Validations
    if (selectedBloodType == null) {
      _showMsg("Please select blood type");
      return;
    }
    if (unitsController.text.isEmpty) {
      _showMsg("Please enter number of units");
      return;
    }
    if (selectedUrgency == null) {
      _showMsg("Please select urgency level");
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 2. Database Submission
      await FirebaseFirestore.instance.collection('requests').add({
        'bloodType': selectedBloodType,
        'units': int.tryParse(unitsController.text) ?? 1,
        'urgency': selectedUrgency,
        'description': descriptionController.text.trim(),
        'status': 'active', // Important for dashboard filtering
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Remove loading indicator
      Navigator.pop(context);

      // 3. Success Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Blood request posted successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Return to hospital dashboard
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context); // Remove loading
      _showMsg("Failed to post request: $e");
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}