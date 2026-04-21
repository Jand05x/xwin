// Hospital management dashboard for posting requests and managing events
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_blood_request_screen.dart';
import 'view_donors_screen.dart';
import 'create_event_screen.dart';
import 'error_widgets.dart'; // Ensure you've created the error_widgets.dart file

class HospitalDashboardScreen extends StatefulWidget {
  const HospitalDashboardScreen({super.key});

  @override
  State<HospitalDashboardScreen> createState() => _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState extends State<HospitalDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Dashboard"),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder(
        // Task: Listening to requests first
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> requestSnapshot) {
          
          // Handle Error State for Requests
          if (requestSnapshot.hasError) {
            return AppErrorWidget(
              message: "Failed to sync blood requests.",
              onRetry: () => setState(() {}),
            );
          }

          return StreamBuilder(
            // Task: Listening to events
            stream: FirebaseFirestore.instance.collection('events').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> eventSnapshot) {
              
              // Handle Error State for Events
              if (eventSnapshot.hasError) {
                return AppErrorWidget(
                  message: "Failed to sync planned events.",
                  onRetry: () => setState(() {}),
                );
              }

              // Handle Loading State
              if (requestSnapshot.connectionState == ConnectionState.waiting ||
                  eventSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.amber),
                      SizedBox(height: 16),
                      Text("Updating Dashboard...")
                    ],
                  ),
                );
              }

              // Calculate live counts
              int activeRequestCount = requestSnapshot.hasData 
                  ? requestSnapshot.data!.docs.where((doc) => doc['status'] == 'active').length 
                  : 0;
                  
              int plannedEventCount = eventSnapshot.hasData 
                  ? eventSnapshot.data!.docs.length 
                  : 0;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "$activeRequestCount",
                            "Active Requests",
                            Colors.red,
                            Icons.bloodtype,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildStatCard(
                            "$plannedEventCount",
                            "Events Planned",
                            Colors.blue,
                            Icons.event,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Hospital Actions",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    _actionButton(
                      "Post Blood Request",
                      Colors.red,
                      Icons.bloodtype,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PostBloodRequestScreen()),
                      ),
                    ),

                    _actionButton(
                      "Create Event", 
                      Colors.blue, 
                      Icons.event, 
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateEventScreen()),
                      ),
                    ),

                    _actionButton(
                      "View Donors", 
                      Colors.orange, 
                      Icons.people, 
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewDonorsScreen()),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "System Connectivity",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _buildActivityTile(
                              Icons.cloud_done, 
                              Colors.green, 
                              "Database Connected", 
                              "Live sync active"
                            ),
                            const Divider(),
                            _buildActivityTile(
                              Icons.security, 
                              Colors.blue, 
                              "Encrypted Session", 
                              "Data transmission secured"
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildActivityTile(IconData icon, Color color, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      dense: true,
    );
  }

  Widget _buildStatCard(String number, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            number,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, Color color, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          icon: Icon(icon, size: 24),
          label: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}