import 'package:flutter/material.dart';

class LearnAboutDonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn About Donation"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: ListView(
          children: [
            SizedBox(height: 20),

            Center(
              child: Icon(Icons.favorite, size: 100, color: Colors.pink),
            ),

            SizedBox(height: 30),

            Text(
              "Popular Articles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            _buildArticleCard(
              title: "Benefits of Blood Donation",
              desc: "Learn how donating helps you and others.",
            ),

            SizedBox(height: 20),
            _buildArticleCard(
              title: "Who Can Donate?",
              desc: "Eligibility rules and safety info.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard({required String title, required String desc}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 6),

            Text(desc),
          ],
        ),
      ),
    );
  }
}
