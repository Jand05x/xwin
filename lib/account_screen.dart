import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 20),
            Text("User Name", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("user@email.com"),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.bloodtype),
              title: Text("Blood Type: A+"),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Points: 240"),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Log Out", style: TextStyle(color: Colors.red)),
              onTap: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                        ),
                        TextButton(
                          child: Text("Logout", style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                            Navigator.pushReplacementNamed(context, '/login'); // Go to login
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
