import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Task: Implementation for clearing notifications
  Future<void> _clearAllNotifications(BuildContext context) async {
    final collection = FirebaseFirestore.instance.collection('notifications');
    final snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All notifications cleared")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => _clearAllNotifications(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return _buildEmptyState();

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => _buildNotificationCard(context, snapshot.data!.docs[index]),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text("No new notifications", style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    IconData iconData = Icons.notifications;
    Color iconColor = Colors.grey;

    if (data['type'] == 'match') { iconData = Icons.check_circle; iconColor = Colors.green; }
    else if (data['type'] == 'urgent') { iconData = Icons.warning; iconColor = Colors.red; }
    else if (data['type'] == 'event') { iconData = Icons.event; iconColor = Colors.blue; }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(iconData, color: iconColor),
        ),
        title: Text(data['title'] ?? 'Notification', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(data['message'] ?? ''),
        trailing: data['type'] == 'match' 
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () => Navigator.pushNamed(context, '/requests'),
              child: const Text("Respond"),
            )
          : null,
      ),
    );
  }
}