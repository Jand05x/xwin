// Screen where users log into their account
import 'package:flutter/material.dart';

// StatefulWidget because we need to track input and loading state
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to get text from input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Track if login is in progress
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),  // Space around content

        child: Column(
          children: [
            SizedBox(height: 40),  // Top spacing

            // Email input field
            TextField(
              controller: emailController,  // Links controller to get text
              decoration: InputDecoration(
                labelText: "Email",  // Label above field
                border: OutlineInputBorder(),  // Box around field
                prefixIcon: Icon(Icons.email),  // Email icon on left
              ),
            ),

            SizedBox(height: 20),  // Space between fields

            // Password input field
            TextField(
              controller: passwordController,  // Links controller to get text
              obscureText: true,  // Hide password with dots
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),  // Lock icon on left
              ),
            ),

            SizedBox(height: 30),

            // Login button
            SizedBox(
              width: double.infinity,  // Make button full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

                // Disable button while loading
                onPressed: isLoading ? null : _loginUser,

                // Show loading spinner or text
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Login", style: TextStyle(fontSize: 18)),
              ),
            ),

            SizedBox(height: 20),

            // Link to registration screen
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Don't have an account? Sign Up"),
            )
          ],
        ),
      ),
    );
  }

  // Function that handles login process
  void _loginUser() async {
    // Validate email field is not empty
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email")),
      );
      return;  // Stop execution
    }

    // Validate password field is not empty
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your password")),
      );
      return;
    }

    // Check if email format is valid (contains @)
    if (!emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email")),
      );
      return;
    }

    // Show loading spinner
    setState(() => isLoading = true);

    // Simulate network delay (in real app, this would call backend)
    await Future.delayed(Duration(seconds: 1));

    // Hide loading spinner
    setState(() => isLoading = false);

    // Navigate to home screen and remove all previous screens
    Navigator.pushReplacementNamed(context, '/home');
  }
}