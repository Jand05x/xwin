// Screen showing list of registered blood donors
import 'package:flutter/material.dart';

// StatelessWidget because donor list is static (in real app would fetch from database)
class ViewDonorsScreen extends StatelessWidget {
  // Sample donor data (in production, this comes from backend database)
  final List<Map<String, dynamic>> donors = [
    {
      "name": "Ahmed Ali",
      "bloodType": "A+",
      "phone": "0770 123 4567",
      "lastDonation": "2 months ago",
      "totalDonations": 5,
      "status": "Available", // Whether donor can donate now
    },
    {
      "name": "Sara Mohammed",
      "bloodType": "O+",
      "phone": "0750 987 6543",
      "lastDonation": "4 months ago",
      "totalDonations": 8,
      "status": "Available",
    },
    {
      "name": "Jand Ayoub",
      "bloodType": "B+",
      "phone": "0780 456 7890",
      "lastDonation": "1 month ago",
      "totalDonations": 3,
      "status": "Not Available", // Too recent donation
    },
    {
      "name": "Layla Hassan",
      "bloodType": "AB+",
      "phone": "0760 321 9876",
      "lastDonation": "6 months ago",
      "totalDonations": 12,
      "status": "Available",
    },
    {
      "name": "Omar Khalil",
      "bloodType": "O-",
      "phone": "0770 555 4444",
      "lastDonation": "3 months ago",
      "totalDonations": 7,
      "status": "Available",
    },
  ];

   ViewDonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar with search button
      appBar: AppBar(
        title: Text("Registered Donors"),
        backgroundColor: Colors.red,
        actions: [
          // Search icon button (placeholder functionality)
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Search feature coming soon!")),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Statistics bar at top
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red[50], // Light red background
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Total donors count
                _buildStatItem("Total Donors", "${donors.length}"),

                // Available donors count (filtered from list)
                _buildStatItem(
                  "Available",
                  "${donors.where((d) => d['status'] == 'Available').length}",
                ),
              ],
            ),
          ),

          // Scrollable list of donor cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: donors.length, // Number of cards to build
              // Build each donor card
              itemBuilder: (context, index) {
                return _buildDonorCard(context, donors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Creates a statistic display with label and value
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        // Large number
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 4),
        // Label below number
        Text(label, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }

  // Creates a donor information card
  Widget _buildDonorCard(BuildContext context, Map<String, dynamic> donor) {
    // Check if donor is currently available to donate
    bool isAvailable = donor['status'] == 'Available';

    return Card(
      margin: EdgeInsets.only(bottom: 12), // Space below card
      elevation: 2, // Shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),

      child: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                // Profile picture placeholder
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red[100],
                  child: Icon(Icons.person, size: 35, color: Colors.red),
                ),

                SizedBox(width: 15),

                // Donor information section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Donor name
                      Text(
                        donor['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      // Blood type and donation count
                      Row(
                        children: [
                          Icon(Icons.bloodtype, size: 16, color: Colors.red),
                          SizedBox(width: 4),
                          Text(
                            donor['bloodType'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.favorite, size: 16, color: Colors.pink),
                          SizedBox(width: 4),
                          Text("${donor['totalDonations']} donations"),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status badge (Available/Not Available)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isAvailable ? Colors.green[100] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20), // Pill shape
                  ),
                  child: Text(
                    donor['status'],
                    style: TextStyle(
                      color: isAvailable ? Colors.green[800] : Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Contact information row
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                SizedBox(width: 6),
                Text(donor['phone']),
                SizedBox(width: 20),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                SizedBox(width: 6),
                Text("Last: ${donor['lastDonation']}"),
              ],
            ),

            SizedBox(height: 12),

            // Contact button (only enabled if donor is available)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.call, size: 18),
                label: Text("Contact Donor"),
                style: ElevatedButton.styleFrom(
                  // Button color changes based on availability
                  backgroundColor: isAvailable ? Colors.red : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                // Button only works if donor is available
                onPressed: isAvailable
                    ? () {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Contact ${donor['name']}"),
                            content: Text("Call ${donor['phone']}?"),
                            actions: [
                              // Cancel button
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              // Call button
                              TextButton(
                                child: Text("Call"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Show calling message (in real app, would initiate phone call)
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Calling ${donor['name']}...",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    : null, // Disabled if not available
              ),
            ),
          ],
        ),
      ),
    );
  }
}
