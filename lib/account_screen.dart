// Screen showing user profile information and allows profile updates
import 'package:flutter/material.dart';

// StatefulWidget to track profile updates
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController nameController = TextEditingController(
    text: "User Name",
  );
  final TextEditingController emailController = TextEditingController(
    text: "user@email.com",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "0770 123 4567",
  );

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false, // Hide back button
        actions: [
          // Edit/Save button
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
              if (!isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profile updated successfully!")),
                );
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16), // Space around content

        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile picture (placeholder icon)
              CircleAvatar(
                radius: 50, // Size of circle
                child: Icon(Icons.person, size: 50),
              ),

              SizedBox(height: 20),

              // User's name (editable)
              if (isEditing)
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Full Name"),
                )
              else
                Text(
                  nameController.text,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

              SizedBox(height: 10),

              // User's email (editable)
              if (isEditing)
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                )
              else
                Text(emailController.text),

              SizedBox(height: 20),

              // User's phone (editable)
              if (isEditing)
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone Number"),
                )
              else
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(phoneController.text),
                ),

              // Blood type information
              ListTile(
                leading: Icon(Icons.bloodtype), // Blood drop icon
                title: Text("Blood Type: A+"),
              ),

              // Points earned information
              ListTile(
                leading: Icon(Icons.star), // Star icon
                title: Text("Points: 240"),
              ),

              // Total donations
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.red),
                title: Text("Total Donations: 12"),
              ),

              SizedBox(height: 20),

              // Change password button
              ElevatedButton.icon(
                icon: Icon(Icons.lock),
                label: Text("Change Password"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/change_password');
                },
              ),

              SizedBox(height: 10),

              // Logout option
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Log Out", style: TextStyle(color: Colors.red)),

                onTap: () {
                  // Show confirmation dialog before logging out
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),

                        actions: [
                          // Cancel button - closes dialog
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                          ),

                          // Logout button - logs user out
                          TextButton(
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog

                              // Navigate to login screen and remove all previous screens
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
