// Screen with app settings and preferences
import 'package:flutter/material.dart';
import 'about_app_screen.dart';

// StatelessWidget because settings are displayed only
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,  // Hide back button
      ),

      body: ListView(  // Scrollable list of settings options
        children: [
          // Toggle switch for notifications
          SwitchListTile(
            value: true,  // Currently enabled
            onChanged: (v) {},  // TODO: Handle notification toggle
            title: Text("Notifications"),
          ),

          // Option to change password
          ListTile(
            leading: Icon(Icons.lock),  // Lock icon
            title: Text("Change Password"),
            onTap: () {
              // Navigate to change password screen
              Navigator.pushNamed(context, '/change_password');
            },
          ),

          // Option to change language (placeholder)
          ListTile(
            leading: Icon(Icons.language),  // Language icon
            title: Text("Language"),
            // TODO: Add language selection functionality
          ),

          // Option to view app information
          ListTile(
            leading: Icon(Icons.info),  // Info icon
            title: Text("About App"),
            onTap: () {
              // Navigate to about app screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutAppScreen()),
              );
            },
          ),

          // Dangerous action: Delete account
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text(
              "Delete Account",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Delete Account",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text("Are you sure? This action cannot be undone!"),

                  actions: [
                    // Cancel button
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),

                    // Delete button - permanently deletes account
                    TextButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);  // Close dialog

                        // Show confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Account deleted")),
                        );

                        // Navigate to login screen and remove all previous screens
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}