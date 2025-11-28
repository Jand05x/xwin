import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'welcome_screen.dart';
import 'home_navigation.dart';  // bottom nav

import 'blood_requests_screen.dart';
import 'events_screen.dart';
import 'hospital_dashboard_screen.dart';
import 'verification_queue_screen.dart';
import 'learn_about_donation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) => HomeNavigation(),

        // Other pages
        '/requests': (context) => BloodRequestsScreen(),
        '/events': (context) => EventsScreen(),
        '/hospital_dashboard': (context) => HospitalDashboardScreen(),
        '/verify': (context) => VerificationQueueScreen(),
        '/learn': (context) => LearnAboutDonationScreen(),
      },
    );
  }
}
