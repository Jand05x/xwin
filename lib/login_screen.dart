// Screen where users log into their account
import 'package:flutter/material.dart';

// StatefulWidget because we need to track input and loading state
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
        title: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
        elevation: 4,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20), // Space around content

          child: Column(
            children: [
              SizedBox(height: 40), // Top spacing
              // Login icon
              Icon(Icons.login, size: 60, color: Colors.red),
              SizedBox(height: 20),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Login to your account",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),

              SizedBox(height: 40),

              // Email input field
              TextField(
                controller: emailController, // Links controller to get text
                decoration: InputDecoration(
                  labelText: "Email", // Label above field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ), // Email icon on left
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),

              SizedBox(height: 20), // Space between fields
              // Password input field
              TextField(
                controller: passwordController, // Links controller to get text
                obscureText: true, // Hide password with dots
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.red,
                  ), // Lock icon on left
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),

              SizedBox(height: 30),

              // Login button
              SizedBox(
                width: double.infinity, // Make button full width
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  // Disable button while loading
                  onPressed: isLoading ? null : _loginUser,

                  // Show loading spinner or text
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 20),

              // Link to registration screen
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function that handles login process
  void _loginUser() async {
    // Validate email field is not empty
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter your email")));
      return; // Stop execution
    }

    // Validate password field is not empty
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter your password")));
      return;
    }

    // Check if email format is valid (contains @)
    if (!emailController.text.contains('@')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter a valid email")));
      return;
    }

    // Show loading spinner
    setState(() => isLoading = true);

    // Simulate network delay (in real app, this would call backend)
    await Future.delayed(Duration(seconds: 1));

    // Hide loading spinner
    setState(() => isLoading = false);

    // Navigate to home screen and remove all previous screens
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
