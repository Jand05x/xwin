import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: true,
            onChanged: (v) {},
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About App"),
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text("Delete Account", style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Delete Account", style: TextStyle(color: Colors.red)),
                  content: Text("Are you sure? This action cannot be undone!"),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text("Delete", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Account deleted")),
                        );
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
