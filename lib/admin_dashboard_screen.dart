// Admin management dashboard for system oversight
import 'package:flutter/material.dart';

// StatelessWidget for admin dashboard
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.deepPurple,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Admin Statistics
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "24",
                    "Pending Donors",
                    Colors.orange,
                    Icons.people,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: _statCard(
                    "12",
                    "Hospitals",
                    Colors.blue,
                    Icons.local_hospital,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Donor Verification Section
            Text(
              "Donor Verification",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            _adminButton(
              label: "Verify Donor Identities",
              color: Colors.orange,
              icon: Icons.verified_user,
              onTap: () {
                Navigator.pushNamed(context, "/verify");
              },
            ),

            SizedBox(height: 20),

            // Hospital Management Section
            Text(
              "Hospital Management",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            _adminButton(
              label: "Verify & Manage Hospitals",
              color: Colors.blue,
              icon: Icons.local_hospital,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Hospital Management"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.pending, color: Colors.orange),
                            title: Text("Central Hospital"),
                            subtitle: Text("Status: Pending Approval"),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text("Approve"),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text("City Medical Center"),
                            subtitle: Text("Status: Approved"),
                            trailing: Icon(Icons.verified),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.pending, color: Colors.orange),
                            title: Text("Regional Hospital"),
                            subtitle: Text("Status: Pending Approval"),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text("Approve"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            // System Monitoring Section
            Text(
              "System Monitoring",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            _adminButton(
              label: "View All Blood Requests",
              color: Colors.red,
              icon: Icons.bloodtype,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Active Blood Requests"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.bloodtype, color: Colors.red),
                            title: Text("A+ Blood"),
                            subtitle: Text("Central Hospital - Urgent"),
                            trailing: Text("8 units"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.bloodtype, color: Colors.red),
                            title: Text("O- Blood"),
                            subtitle: Text("City Medical - Emergency"),
                            trailing: Text("5 units"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.bloodtype, color: Colors.red),
                            title: Text("B+ Blood"),
                            subtitle: Text("Regional Hospital"),
                            trailing: Text("3 units"),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 8),

            _adminButton(
              label: "View Donation Events",
              color: Colors.green,
              icon: Icons.event,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Donation Events"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.event, color: Colors.green),
                            title: Text("City Blood Drive"),
                            subtitle: Text("Dec 10, 2024 - Downtown"),
                            trailing: Text("45 RSVPs"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.event, color: Colors.green),
                            title: Text("Hospital Campaign"),
                            subtitle: Text("Dec 15, 2024 - Central Hospital"),
                            trailing: Text("28 RSVPs"),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            // System Reports Section
            Text(
              "Reports",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            _adminButton(
              label: "System Statistics",
              color: Colors.purple,
              icon: Icons.bar_chart,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("System Statistics"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("Total Donors"),
                          trailing: Text(
                            "156",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("Total Donations"),
                          trailing: Text(
                            "342",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("Active Hospitals"),
                          trailing: Text(
                            "12",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("Blood Requests"),
                          trailing: Text(
                            "24",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Creates a statistics card
  Widget _statCard(String value, String label, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Creates an admin action button
  Widget _adminButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
