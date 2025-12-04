// First screen users see when opening the app
import 'package:flutter/material.dart';

// StatelessWidget because this screen doesn't change
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Screen background color

      body: Padding(
        padding: const EdgeInsets.all(20), // Add spacing around edges

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically

          children: [
            Spacer(), // Pushes content towards center

            SizedBox(height: 20),

            // App logo icon
            Icon(Icons.navigation, size: 80, color: Colors.red),
            SizedBox(height: 10), // Space between elements
            // App name
            Text(
              "XwinLink",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            // App tagline/description
            Text(
              "Community Blood Network",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            Spacer(), // Pushes buttons to bottom
            // Sign Up button - takes user to registration screen
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
                minimumSize: Size(
                  double.infinity,
                  50,
                ), // Full width, 50px height
              ),
              child: Text("Sign Up"),
              onPressed: () {
                // Navigate to registration screen
                Navigator.pushNamed(context, "/register");
              },
            ),

            SizedBox(height: 10), // Space between buttons
            // Login button - takes user to login screen
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full width
              ),
              child: Text("Login"),
              onPressed: () {
                // Navigate to login screen
                Navigator.pushNamed(context, "/login");
              },
            ),

            SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }
}
