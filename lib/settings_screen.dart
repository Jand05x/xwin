// Screen with app settings and preferences
import 'package:flutter/material.dart';
import 'about_app_screen.dart';

// StatelessWidget because settings are displayed only
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[800],
        automaticallyImplyLeading: false, // Hide back button
        elevation: 4,
      ),
      backgroundColor: Colors.grey[50],
      body: ListView(
        // Scrollable list of settings options
        children: [
          // Notifications Section
          Padding(
            padding: EdgeInsets.only(left: 16, top: 20, bottom: 8),
            child: Text(
              "Preferences",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),

          // Toggle switch for notifications
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: SwitchListTile(
              value: true, // Currently enabled
              onChanged: (v) {}, // TODO: Handle notification toggle
              title: Text(
                "Notifications",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Receive alerts and updates"),
              activeThumbColor: Colors.red,
            ),
          ),

          SizedBox(height: 8),

          // Security Section
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              "Security & Account",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),

          // Option to change password
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.lock, color: Colors.red), // Lock icon
              title: Text(
                "Change Password",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Update your password"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                // Navigate to change password screen
                Navigator.pushNamed(context, '/change_password');
              },
            ),
          ),

          SizedBox(height: 8),

          // Information Section
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              "Information",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),

          // Option to change language (placeholder)
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.blue), // Language
              title: Text(
                "Language",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Choose your language"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              // TODO: Add language selection functionality
            ),
          ),

          SizedBox(height: 8),

          // Option to view app information
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.green), // Info icon
              title: Text(
                "About App",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Version 1.0.0"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                // Navigate to about app screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppScreen()),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          // Danger Zone Section
          Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              "Danger Zone",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),

          // Dangerous action: Delete account
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.red[50],
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text(
                "Delete Account",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                "Permanently delete your account",
                style: TextStyle(color: Colors.red[300]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.red,
              ),
              onTap: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Delete Account",
                        style: TextStyle(color: Colors.red),
                      ),
                      content: Text(
                        "This action cannot be undone. Your account and all data will be permanently deleted.",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      actions: [
                        // Cancel button
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        // Delete button - permanently deletes account
                        TextButton(
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close dialog

                            // Show confirmation message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Account deleted")),
                            );

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
          ),
        ],
      ),
    );
  }
}
