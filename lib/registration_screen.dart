// Screen where new donors register their information
import 'package:flutter/material.dart';

// StatefulWidget because we need to track input and dropdown selections
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers to get text from input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController lastDonationController = TextEditingController();

  // Variable to store selected blood type from dropdown
  String? selectedBloodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Donor Registration"),
      ),

      body: SingleChildScrollView(
        // Makes screen scrollable if content is long
        padding: EdgeInsets.all(16), // Space around content

        child: Column(
          children: [
            // Full name input field
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),

            SizedBox(height: 10),

            // Email input field
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),

            SizedBox(height: 10),

            // Phone number input field
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),

            SizedBox(height: 10),

            // Password input field
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            SizedBox(height: 10),

            // Blood type dropdown menu
            DropdownButtonFormField<String>(
              initialValue: selectedBloodType, // Currently selected value
              // List of blood type options
              items: [
                "A+",
                "A-",
                "B+",
                "B-",
                "O+",
                "O-",
                "AB+",
                "AB-",
              ].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),

              // Called when user selects an option
              onChanged: (v) {
                setState(() => selectedBloodType = v); // Update selected value
              },

              decoration: InputDecoration(labelText: "Blood Type"),
            ),

            SizedBox(height: 10),

            // Date picker field for last donation
            TextField(
              controller: lastDonationController,
              decoration: InputDecoration(
                labelText: "Last Donation Date",
                hintText: "Tap to select date",
                suffixIcon: Icon(Icons.calendar_today), // Calendar icon
              ),
              readOnly: true, // Prevent manual typing, only allow date picker
              // When field is tapped, show date picker
              onTap: () async {
                // Show date picker dialog
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), // Start at today
                  firstDate: DateTime(2000), // Earliest selectable date
                  lastDate: DateTime.now(), // Can't select future dates
                );

                // If user selected a date (didn't cancel)
                if (picked != null) {
                  // Format and display the selected date
                  lastDonationController.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),

            SizedBox(height: 20),

            // Button to upload ID document (placeholder functionality)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: Text("Upload ID Document"),
              onPressed: () {}, // TODO: Add file upload functionality
            ),

            SizedBox(height: 10),

            // Button to upload selfie (placeholder functionality)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: Text("Upload Selfie"),
              onPressed: () {}, // TODO: Add camera/file upload functionality
            ),

            SizedBox(height: 20),

            // Submit button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50), // Full width
              ),
              child: Text("Submit"),

              onPressed: () {
                // Validate all required fields are filled

                // Check name
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your name")),
                  );
                  return;
                }

                // Check email
                if (emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your email")),
                  );
                  return;
                }

                // Validate email format
                if (!emailController.text.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid email")),
                  );
                  return;
                }

                // Check phone
                if (phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your phone number")),
                  );
                  return;
                }

                // Check blood type selection
                if (selectedBloodType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select your blood type")),
                  );
                  return;
                }

                // If all validations pass, show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Registration Successful!"),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate to home screen and remove all previous screens
                Navigator.pushReplacementNamed(context, "/home");
              },
            ),
          ],
        ),
      ),
    );
  }
}
