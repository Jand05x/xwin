// Screen showing user profile information and logout option
import 'package:flutter/material.dart';

// StatelessWidget because profile info is displayed only, not edited here
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,  // Hide back button
      ),

      body: Padding(
        padding: EdgeInsets.all(16),  // Space around content

        child: Column(
          children: [
            // Profile picture (placeholder icon)
            CircleAvatar(
              radius: 50,  // Size of circle
              child: Icon(Icons.person, size: 50),
            ),

            SizedBox(height: 20),

            // User's name
            Text(
              "User Name",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // User's email
            Text("user@email.com"),

            SizedBox(height: 20),

            // Blood type information
            ListTile(
              leading: Icon(Icons.bloodtype),  // Blood drop icon
              title: Text("Blood Type: A+"),
            ),

            // Points earned information
            ListTile(
              leading: Icon(Icons.star),  // Star icon
              title: Text("Points: 240"),
            ),

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
                            Navigator.of(context).pop();  // Close dialog
                          },
                        ),

                        // Logout button - logs user out
                        TextButton(
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();  // Close dialog

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
    );
  }
}