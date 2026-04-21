import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDonorsScreen extends StatelessWidget {
  // Added 'const' to satisfy the lint warning task
  const ViewDonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Donors"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search feature coming soon!")),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donors').snapshots(),
        builder: (context, snapshot) {
          // Error handling widget added for code quality task
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text("Error: ${snapshot.error}"),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          final List<Map<String, dynamic>> donors = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return data;
          }).toList();

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.red[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("Total Donors", "${donors.length}"),
                    _buildStatItem(
                      "Available",
                      "${donors.where((d) => d['status'] == 'Available').length}",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    return _buildDonorCard(context, donors[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildDonorCard(BuildContext context, Map<String, dynamic> donor) {
    bool isAvailable = donor['status'] == 'Available';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red[100],
                  child: const Icon(Icons.person, size: 35, color: Colors.red),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donor['name'] ?? "Unknown Donor",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.bloodtype, size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            donor['bloodType'] ?? "N/A",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(Icons.favorite, size: 16, color: Colors.pink),
                          const SizedBox(width: 4),
                          Text("${donor['totalDonations'] ?? 0} donations"),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isAvailable ? Colors.green[100] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    donor['status'] ?? "pending",
                    style: TextStyle(
                      color: isAvailable ? Colors.green[800] : Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(donor['phone'] ?? "No Phone"),
                const SizedBox(width: 20),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("Last: ${donor['lastDonation'] ?? "Never"}"),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.call, size: 18, color: Colors.white),
                label: const Text("Contact Donor", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAvailable ? Colors.red : Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: isAvailable
                    ? () {
                        _showContactDialog(context, donor['name'], donor['phone']);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context, String? name, String? phone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact ${name ?? 'Donor'}"),
        content: Text("Call ${phone ?? 'this number'}?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Call"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Calling ${name ?? 'Donor'}...")),
              );
            },
          ),
        ],
      ),
    );
  }
}