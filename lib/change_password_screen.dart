// Screen where users can change their password
import 'package:flutter/material.dart';

// StatefulWidget because we need to track form state and inputs
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Form key to handle validation
  final _formKey = GlobalKey<FormState>();

  // Controllers to get text from password fields
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Validates and changes password
  void _changePassword() {
    // Check if all form validations pass
    if (_formKey.currentState!.validate()) {
      // TODO: Add backend logic to update password in database

      // Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password changed successfully!')));

      // Return to previous screen
      Navigator.pop(context);
    }
  }

  // Clean up controllers when screen is disposed
  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // Form widget to handle validation
        child: Form(
          key: _formKey, // Links form key

          child: Column(
            children: [
              // Current password input field
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true, // Hide password with dots
                decoration: InputDecoration(labelText: 'Current Password'),

                // Validation: check if field is empty
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current password';
                  }
                  return null; // Validation passed
                },
              ),

              SizedBox(height: 16),

              // New password input field
              TextFormField(
                controller: _newPasswordController,
                obscureText: true, // Hide password with dots
                decoration: InputDecoration(labelText: 'New Password'),

                // Validation: check if empty and minimum length
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null; // Validation passed
                },
              ),

              SizedBox(height: 16),

              // Confirm password input field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true, // Hide password with dots
                decoration: InputDecoration(labelText: 'Confirm New Password'),

                // Validation: check if matches new password
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null; // Validation passed
                },
              ),

              SizedBox(height: 32),

              // Change password button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: _changePassword, // Call validation function
                child: Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
