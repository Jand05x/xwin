import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'welcome_screen.dart';
import 'home_navigation.dart'; 
import 'blood_requests_screen.dart';
import 'events_screen.dart';
import 'hospital_dashboard_screen.dart';
import 'admin_dashboard_screen.dart';
import 'verification_queue_screen.dart';
import 'learn_about_donation_screen.dart';
import 'change_password_screen.dart';
import 'notifications_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDFHu-DOItcroStX_6Xmb1XsEFtHIcjaLU",
      appId: "1:677104751369:web:e8e02c89fec8173d2bb9d8",
      messagingSenderId: "677104751369",
      projectId: "xwin2-40f87",
      authDomain: "xwin2-40f87.firebaseapp.com",
      storageBucket: "xwin2-40f87.firebasestorage.app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      home: const AuthWrapper(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeNavigation(),
        '/admin_dashboard': (context) => const AdminDashboardScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (!authSnapshot.hasData) {
          return const WelcomeScreen(); 
        }

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(authSnapshot.data!.uid)
              .get(),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (roleSnapshot.hasData && roleSnapshot.data!.exists) {
              final userData = roleSnapshot.data!.data() as Map<String, dynamic>;
              String role = (userData['role'] ?? 'donor').toString().trim().toLowerCase();

              // Check your Debug Console for this:
              print("DEBUG: Logged in as UID: ${authSnapshot.data!.uid}");
              print("DEBUG: Role found in DB: '$role'");

              if (role == 'admin') return const AdminDashboardScreen();
              if (role == 'hospital') return const HospitalDashboardScreen();
              return const HomeNavigation();
            }

            print("DEBUG: Document does not exist for this UID in 'users' collection.");
            return const HomeNavigation();
          },
        );
      },
    );
  }
}