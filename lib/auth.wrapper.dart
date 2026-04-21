import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hospital_dashboard_screen.dart'; // Import your hospital screen
import 'admin_dashboard_screen.dart';    // Import your admin screen
import 'login_screen.dart';        // Import your login screen

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        // 1. If not logged in, go to Login Screen
        if (!authSnapshot.hasData) {
          return const LoginScreen();
        }

        // 2. If logged in, check the Firestore role
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(authSnapshot.data!.uid)
              .get(),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (roleSnapshot.hasData && roleSnapshot.data!.exists) {
              String role = roleSnapshot.data!['role'];

              if (role == 'admin') {
                return const AdminDashboardScreen();
              } else if (role == 'hospital') {
                return const HospitalDashboardScreen();
              }
            }

            // Fallback if role is missing or user doc doesn't exist
            return const LoginScreen();
          },
        );
      },
    );
  }
}