// Screen where hospitals create blood donation events
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added for database integration

// StatefulWidget because we need to track form inputs
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // Controllers to get text from input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Task: Cleanup controllers to prevent memory leaks
  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"), 
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Event Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Event title input
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Event Title",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.event, color: Colors.blue),
                hintText: "e.g., Community Blood Drive",
              ),
            ),

            SizedBox(height: 15),

            // Location input
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                hintText: "e.g., Duhok Medical Center",
              ),
            ),

            SizedBox(height: 15),

            // Date picker field
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Event Date",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                hintText: "Tap to select date",
              ),
              readOnly: true, 
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2027), // Extended range
                );

                if (picked != null) {
                  dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),

            SizedBox(height: 15),

            // Time picker field
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: "Event Time",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time, color: Colors.blue),
                hintText: "Tap to select time",
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (picked != null) {
                  timeController.text = picked.format(context);
                }
              },
            ),

            SizedBox(height: 15),

            // Event description input (multi-line)
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Event Description",
                border: OutlineInputBorder(),
                hintText: "Details about the event...",
              ),
            ),

            SizedBox(height: 30),

            // Create event button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _createEvent, // Call logic function
                child: Text(
                  "Create Event",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Task: Logic to save event data to Firestore
  Future<void> _createEvent() async {
    // 1. Validation
    if (titleController.text.isEmpty || 
        locationController.text.isEmpty || 
        dateController.text.isEmpty || 
        timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields"))
      );
      return;
    }

    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 2. Database Submission
      await FirebaseFirestore.instance.collection('events').add({
        'title': titleController.text.trim(),
        'location': locationController.text.trim(),
        'date': dateController.text,
        'time': timeController.text,
        'description': descriptionController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context); // Remove loading

      // 3. Success Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Event created successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context); // Go back to dashboard
    } catch (e) {
      Navigator.pop(context); // Remove loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creating event: $e"))
      );
    }
  }
}