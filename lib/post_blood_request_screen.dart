import 'package:flutter/material.dart';

class PostBloodRequestScreen extends StatefulWidget {
  @override
  _PostBloodRequestScreenState createState() => _PostBloodRequestScreenState();
}

class _PostBloodRequestScreenState extends State<PostBloodRequestScreen> {
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedBloodType;
  String? selectedUrgency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Blood Request"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Request Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Blood Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedBloodType,
              decoration: InputDecoration(
                labelText: "Blood Type Needed",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.bloodtype, color: Colors.red),
              ),
              items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (v) {
                setState(() => selectedBloodType = v);
              },
            ),

            SizedBox(height: 15),

            // Units Needed
            TextField(
              controller: unitsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number of Units",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.opacity, color: Colors.red),
                hintText: "e.g., 2",
              ),
            ),

            SizedBox(height: 15),

            // Urgency Level
            DropdownButtonFormField<String>(
              value: selectedUrgency,
              decoration: InputDecoration(
                labelText: "Urgency Level",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.warning, color: Colors.orange),
              ),
              items: ["Urgent", "Within 24 hours", "Scheduled"]
                  .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                  .toList(),
              onChanged: (v) {
                setState(() => selectedUrgency = v);
              },
            ),

            SizedBox(height: 15),

            // Description
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Additional Details (Optional)",
                border: OutlineInputBorder(),
                hintText: "Patient condition, specific requirements...",
              ),
            ),

            SizedBox(height: 30),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitRequest,
                child: Text(
                  "Post Request",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRequest() {
    // Validate fields
    if (selectedBloodType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select blood type")),
      );
      return;
    }

    if (unitsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter number of units")),
      );
      return;
    }

    if (selectedUrgency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select urgency level")),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Blood request posted successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // Go back to hospital dashboard
    Navigator.pop(context);
  }
}