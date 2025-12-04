// Screen showing information about the XwinLink app
import 'package:flutter/material.dart';

// StatelessWidget because content is static
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(title: Text("About App"), backgroundColor: Colors.red),

      body: SingleChildScrollView(
        // Makes content scrollable
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            SizedBox(height: 20),

            // App logo icon
            Icon(Icons.favorite, size: 100, color: Colors.red),

            SizedBox(height: 15),

            // App name
            Text(
              "XwinLink",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            SizedBox(height: 5),

            // App tagline
            Text(
              "Community Blood Network",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            SizedBox(height: 10),

            // Version number
            Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),

            SizedBox(height: 30),

            // About section card
            Card(
              elevation: 2, // Shadow depth
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    Text(
                      "About XwinLink",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Mission statement
                    Text(
                      "XwinLink is a community-driven platform connecting blood donors with those in need. Our mission is to save lives by making blood donation easier and more accessible.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    SizedBox(height: 15),

                    // Additional description
                    Text(
                      "Through our app, hospitals can post urgent blood requests, organize donation events, and connect with registered donors in real-time.",
                      style: TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Features section card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    Text(
                      "Key Features",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),

                    // List all key features
                    _buildFeature(
                      Icons.bloodtype,
                      "Find Blood Requests",
                      "Discover urgent blood needs near you",
                    ),
                    _buildFeature(
                      Icons.event,
                      "Donation Events",
                      "Participate in community blood drives",
                    ),
                    _buildFeature(
                      Icons.verified_user,
                      "Verified Donors",
                      "Secure identity verification process",
                    ),
                    _buildFeature(
                      Icons.local_hospital,
                      "Hospital Network",
                      "Connected with trusted medical facilities",
                    ),
                    _buildFeature(
                      Icons.stars,
                      "Earn Points",
                      "Get rewarded for saving lives",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Contact information card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Contact methods
                    _buildContactItem(Icons.email, "support@xwinlink.com"),
                    _buildContactItem(Icons.phone, "+964 770 123 4567"),
                    _buildContactItem(Icons.language, "www.xwinlink.com"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Social media section
            Text(
              "Follow Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // Social media icon buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(Icons.facebook, Colors.blue[800]!),
                SizedBox(width: 15),
                _buildSocialButton(Icons.camera_alt, Colors.purple),
                SizedBox(width: 15),
                _buildSocialButton(Icons.message, Colors.blue),
              ],
            ),

            SizedBox(height: 30),

            // Copyright footer
            Text(
              "© 2025 XwinLink. All rights reserved.",
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),

            SizedBox(height: 10),

            // Made with love message
            Text(
              "Made with ❤️ for the community",
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Creates a feature row with icon, title, and description
  Widget _buildFeature(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Feature icon
          Icon(icon, color: Colors.red, size: 24),
          SizedBox(width: 15),

          // Feature text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Feature title
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                // Feature description
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Creates a contact information row
  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 20),
          SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  // Creates a circular social media button
  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle, // Makes container circular
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
