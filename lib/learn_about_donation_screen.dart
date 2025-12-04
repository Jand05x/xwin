// Educational screen with articles about blood donation
import 'package:flutter/material.dart';

// Data model class to store article information
class Article {
  final String title;
  final String description;
  final String content;

  const Article({
    required this.title,
    required this.description,
    required this.content,
  });
}

// StatelessWidget because article list is static
class LearnAboutDonationScreen extends StatelessWidget {
  const LearnAboutDonationScreen({super.key});

  // List of educational articles
  final List<Article> _articles = const [
    // Article 1: Benefits of donation
    Article(
      title: "Benefits of Blood Donation",
      description: "Learn how donating helps your health and saves lives.",
      content:
          "Donating blood is one of the easiest ways to help people in emergencies, surgeries, and cancer treatment. "
          "One donation can save up to three lives because blood is separated into red cells, plasma, and platelets.\n\n"
          "Regular donors may also benefit from basic health checks done before each donation such as blood pressure "
          "and hemoglobin tests. Some studies suggest that regular donation can help reduce iron overload in people "
          "with high iron levels, which may support heart health.\n\n"
          "Most importantly, blood donation builds a culture of solidarity in the community and reminds us that small "
          "actions can make a big impact.",
    ),

    // Article 2: Eligibility requirements
    Article(
      title: "Who Can Donate?",
      description: "Basic eligibility rules and safety information.",
      content:
          "Most healthy adults can donate blood, but there are a few important rules to keep everyone safe. "
          "In general, you must be within the allowed age range in your country, meet the minimum weight, and feel well "
          "on the day of donation.\n\n"
          "Doctors will ask about your medical history, medications, travel, and lifestyle to be sure donating is safe "
          "for you and the person receiving your blood. If you have a fever, infection, or certain medical conditions, "
          "you may need to wait before donating.\n\n"
          "If you are unsure, talk to medical staff at the donation center – they will guide you and explain when you "
          "can donate again.",
    ),

    // Article 3: Preparation tips
    Article(
      title: "How to Prepare for Donation Day",
      description: "Simple steps to make your donation easier and safer.",
      content:
          "Good preparation makes blood donation more comfortable. The day before, drink plenty of water and have "
          "regular meals. Avoid heavy, very fatty foods right before donating, as they can affect some test results.\n\n"
          "On the day of donation, wear comfortable clothes with sleeves that can be rolled up. Bring an ID card and any "
          "medical information you may need.\n\n"
          "After donating, rest for a few minutes, drink the juice or water they offer, and avoid heavy exercise for the "
          "rest of the day. If you feel dizzy, sit or lie down until you feel better. Taking care of yourself helps you "
          "donate again in the future.",
    ),

    // Article 4: Common misconceptions
    Article(
      title: "Common Myths About Blood Donation",
      description: "Clearing up fears and misunderstandings.",
      content:
          "Many people are afraid to donate because of myths they have heard. One common myth is that donating blood "
          "makes you weak for a long time. In reality, your body replaces the donated fluid within 24 hours and the red "
          "blood cells within a few weeks.\n\n"
          "Another myth is that you can get infections from donating. Donation centers use new, sterile needles for every "
          "donor and dispose of them immediately, so there is no risk of catching diseases from the process.\n\n"
          "If you have questions or fears, talk openly with the medical team. They are trained to keep you safe and "
          "comfortable.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: const Text("Learn About Donation"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          // Scrollable content
          children: [
            const SizedBox(height: 20),

            // Heart icon decoration
            const Center(
              child: Icon(Icons.favorite, size: 100, color: Colors.pink),
            ),

            const SizedBox(height: 30),

            // Section title
            const Text(
              "Popular Articles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Build all article cards using map function
            ..._articles.map((article) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildArticleCard(context, article),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Creates a clickable article preview card
  Widget _buildArticleCard(BuildContext context, Article article) {
    return Card(
      elevation: 4, // Shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),

      // InkWell makes card clickable with ripple effect
      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        // When card is tapped, navigate to full article
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailScreen(article: article),
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Article title
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // Article description/preview
              Text(
                article.description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 12),

              // "Read more" link with arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Read more",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Full article detail screen
class ArticleDetailScreen extends StatelessWidget {
  final Article article; // Article to display

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar with article title
      appBar: AppBar(title: Text(article.title), backgroundColor: Colors.red),

      body: SingleChildScrollView(
        // Make content scrollable
        padding: const EdgeInsets.all(16),

        // Display full article content
        child: Text(
          article.content,
          style: const TextStyle(fontSize: 16, height: 1.5), // Line spacing
        ),
      ),
    );
  }
}
