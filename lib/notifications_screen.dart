// Screen showing system notifications and alerts
import 'package:flutter/material.dart';

// StatelessWidget for displaying notifications
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications (in real app, would come from backend)
    final List<Map<String, dynamic>> notifications = [
      {
        "type": "match",
        "title": "Blood Match Found!",
        "message": "Your blood type A+ is needed at Central Hospital",
        "timestamp": "2 hours ago",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "type": "eligibility",
        "title": "Eligibility Updated",
        "message": "You are now eligible to donate again",
        "timestamp": "1 day ago",
        "icon": Icons.verified,
        "color": Colors.blue,
      },
      {
        "type": "event",
        "title": "Event Reminder",
        "message": "Blood drive at City Hospital starts in 2 days",
        "timestamp": "3 days ago",
        "icon": Icons.event,
        "color": Colors.orange,
      },
      {
        "type": "urgent",
        "title": "Urgent: O- Blood Needed",
        "message":
            "Emergency blood request - Regional Hospital needs O- donors now",
        "timestamp": "5 hours ago",
        "icon": Icons.warning,
        "color": Colors.red,
      },
      {
        "type": "verification",
        "title": "Verification Approved",
        "message": "Your identity has been verified successfully",
        "timestamp": "1 week ago",
        "icon": Icons.done_all,
        "color": Colors.green,
      },
      {
        "type": "event",
        "title": "Event Cancelled",
        "message": "Blood drive at Downtown Center has been postponed",
        "timestamp": "1 week ago",
        "icon": Icons.cancel,
        "color": Colors.grey,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.red,
        actions: [
          // Clear all notifications button
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("All notifications cleared")),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  // Builds individual notification card
  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: notification['color'].withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                notification['icon'],
                color: notification['color'],
                size: 28,
              ),
            ),
            SizedBox(width: 12),
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    notification['title'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  // Message
                  Text(
                    notification['message'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 6),
                  // Timestamp
                  Text(
                    notification['timestamp'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            // Action button based on notification type
            if (notification['type'] == 'match')
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {},
                child: Text("Respond", style: TextStyle(fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }
}
