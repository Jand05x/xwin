import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(Icons.navigation, size: 80, color: Colors.red),
            SizedBox(height: 10),
            Text(
              "XwinLink",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "Community Blood Network",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Sign Up"),
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
