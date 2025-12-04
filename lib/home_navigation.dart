// Main navigation screen with bottom tabs (Home, Account, Settings)
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'account_screen.dart';
import 'settings_screen.dart';

// StatefulWidget because we need to track which tab is selected
class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  // Tracks which tab is currently selected (0 = Home, 1 = Account, 2 = Settings)
  int _currentIndex = 0;

  // List of screens corresponding to each bottom tab
  final List<Widget> _pages = [
    DashboardScreen(), // Home tab
    AccountScreen(), // Account tab
    SettingsScreen(), // Settings tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the currently selected screen
      body: _pages[_currentIndex],

      // Bottom navigation bar with 3 tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight selected tab
        selectedItemColor: Colors.red, // Color for selected tab
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        // Called when user taps a tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected tab
          });
        },

        // Define the 3 bottom tabs
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
