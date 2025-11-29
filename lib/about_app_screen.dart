import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),

            // App Logo
            Icon(
              Icons.favorite,
              size: 100,
              color: Colors.red,
            ),

            SizedBox(height: 15),

            // App Name
            Text(
              "XwinLink",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            SizedBox(height: 5),

            Text(
              "Community Blood Network",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 10),

            // Version
            Text(
              "Version 1.0.0",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),

            SizedBox(height: 30),

            // About Text
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
                    Text(
                      "About XwinLink",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "XwinLink is a community-driven platform connecting blood donors with those in need. Our mission is to save lives by making blood donation easier and more accessible.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Through our app, hospitals can post urgent blood requests, organize donation events, and connect with registered donors in real-time.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Features Card
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
                    Text(
                      "Key Features",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    _buildFeature(Icons.bloodtype, "Find Blood Requests", "Discover urgent blood needs near you"),
                    _buildFeature(Icons.event, "Donation Events", "Participate in community blood drives"),
                    _buildFeature(Icons.verified_user, "Verified Donors", "Secure identity verification process"),
                    _buildFeature(Icons.local_hospital, "Hospital Network", "Connected with trusted medical facilities"),
                    _buildFeature(Icons.stars, "Earn Points", "Get rewarded for saving lives"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Contact Card
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
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    _buildContactItem(Icons.email, "support@xwinlink.com"),
                    _buildContactItem(Icons.phone, "+964 770 123 4567"),
                    _buildContactItem(Icons.language, "www.xwinlink.com"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Social Media
            Text(
              "Follow Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
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

            // Footer
            Text(
              "© 2025 XwinLink. All rights reserved.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Made with ❤️ for the community",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.red, size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 20),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}