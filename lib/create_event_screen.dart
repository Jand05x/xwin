import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
        backgroundColor: Colors.blue,
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

            // Event Title
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

            // Location
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

            // Date Picker
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
                  lastDate: DateTime(2026),
                );

                if (picked != null) {
                  dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),

            SizedBox(height: 15),

            // Time Picker
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

            // Description
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

            // Create Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _createEvent,
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

  void _createEvent() {
    // Validate fields
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter event title")),
      );
      return;
    }

    if (locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter location")),
      );
      return;
    }

    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select event date")),
      );
      return;
    }

    if (timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select event time")),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Event created successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // Go back
    Navigator.pop(context);
  }
}