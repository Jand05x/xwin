import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lastDonationController = TextEditingController();
  String? selectedBloodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Donor Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedBloodType,
              items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (v) {
                setState(() => selectedBloodType = v);
              },
              decoration: InputDecoration(labelText: "Blood Type"),
            ),
            SizedBox(height: 10),TextField(
              controller: lastDonationController,
              decoration: InputDecoration(
                labelText: "Last Donation Date",
                hintText: "Tap to select date",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,  // Don't let user type
              onTap: () async {
                // Show date picker
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                // If user picked a date, show it
                if (picked != null) {
                  lastDonationController.text = "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: Text("Upload ID Document"),
              onPressed: () {},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: Text("Upload Selfie"),
              onPressed: () {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Submit"),
              onPressed: () {
                // Check if all fields are filled
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your name")),
                  );
                  return;
                }

                if (emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your email")),
                  );
                  return;
                }

                if (!emailController.text.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid email")),
                  );
                  return;
                }

                if (phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your phone number")),
                  );
                  return;
                }

                if (selectedBloodType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select your blood type")),
                  );
                  return;
                }

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Registration Successful!"), backgroundColor: Colors.green),
                );

                // Navigate to Home
                Navigator.pushReplacementNamed(context, "/home");
              },
            ),
          ],
        ),
      ),
    );
  }
}
