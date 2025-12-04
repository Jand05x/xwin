// This is the entry point of the application
import 'package:flutter/material.dart';

// Import all screen files
import 'login_screen.dart';
import 'registration_screen.dart';
import 'welcome_screen.dart';
import 'home_navigation.dart'; // Contains bottom navigation bar with 3 tabs
import 'blood_requests_screen.dart';
import 'events_screen.dart';
import 'hospital_dashboard_screen.dart';
import 'admin_dashboard_screen.dart';
import 'verification_queue_screen.dart';
import 'learn_about_donation_screen.dart';
import 'change_password_screen.dart';
import 'notifications_screen.dart';

// The main function runs when app starts
void main() {
  runApp(MyApp()); // Launches the MyApp widget
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Removes debug banner in top-right corner
      initialRoute: '/welcome', // First screen shown when app opens
      // Define all navigation routes (screens) in the app
      routes: {
        '/welcome': (context) =>
            WelcomeScreen(), // Landing page with login/signup buttons
        '/login': (context) => LoginScreen(), // User login page
        '/register': (context) =>
            RegistrationScreen(), // New donor registration
        '/home': (context) =>
            HomeNavigation(), // Main screen with bottom navigation
        // Additional feature screens
        '/requests': (context) => BloodRequestsScreen(), // View blood requests
        '/events': (context) => EventsScreen(), // View donation events
        '/hospital_dashboard': (context) =>
            HospitalDashboardScreen(), // Hospital management
        '/admin_dashboard': (context) =>
            AdminDashboardScreen(), // Admin system management
        '/verify': (context) =>
            VerificationQueueScreen(), // Admin verification queue
        '/learn': (context) =>
            LearnAboutDonationScreen(), // Educational articles
        '/change_password': (context) =>
            ChangePasswordScreen(), // Change password
        '/notifications': (context) =>
            NotificationsScreen(), // System notifications
      },
    );
  }
}
