// Screen where hospitals create blood donation events
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(title: Text("Create Event"), backgroundColor: Colors.blue),

      body: SingleChildScrollView(
        // Makes form scrollable
        padding: EdgeInsets.all(16), // Space around form

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to left

          children: [
            // Form section title
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
              readOnly: true, // Prevent manual typing
              // When tapped, show date picker dialog
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), // Start at today
                  firstDate: DateTime.now(), // Can't select past dates
                  lastDate: DateTime(2026), // Can select up to year 2026
                );

                // If user selected a date (didn't cancel)
                if (picked != null) {
                  // Format and display the selected date
                  dateController.text =
                      "${picked.day}/${picked.month}/${picked.year}";
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
              readOnly: true, // Prevent manual typing
              // When tapped, show time picker dialog
              onTap: () async {
                final ctx = context;
                // ignore: use_build_context_synchronously
                TimeOfDay? picked = await showTimePicker(
                  context: ctx,
                  initialTime: TimeOfDay.now(), // Start at current time
                );

                // If user selected a time (didn't cancel)
                if (picked != null && mounted) {
                  // ignore: use_build_context_synchronously
                  timeController.text = picked.format(ctx);
                }
              },
            ),

            SizedBox(height: 15),

            // Event description input (multi-line)
            TextField(
              controller: descriptionController,
              maxLines: 4, // Multi-line text area
              decoration: InputDecoration(
                labelText: "Event Description",
                border: OutlineInputBorder(),
                hintText: "Details about the event...",
              ),
            ),

            SizedBox(height: 30),

            // Create event button
            SizedBox(
              width: double.infinity, // Full width
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _createEvent, // Call validation function
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

  // Validates form and creates event
  void _createEvent() {
    // Validate title is filled
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter event title")));
      return; // Stop execution
    }

    // Validate location is filled
    if (locationController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter location")));
      return;
    }

    // Validate date is selected
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select event date")));
      return;
    }

    // Validate time is selected
    if (timeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select event time")));
      return;
    }

    // If all validations pass, show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Event created successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // Return to previous screen
    Navigator.pop(context);
  }
}
