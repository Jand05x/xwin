import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerificationQueueScreen extends StatelessWidget {
  const VerificationQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Queue"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donors')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No pending verifications",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return _buildVerificationCard(context, docs[index], docs.length, index + 1);
            },
          );
        },
      ),
    );
  }

  Widget _buildVerificationCard(BuildContext context, DocumentSnapshot doc, int total, int current) {
    final data = doc.data() as Map<String, dynamic>;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data['name'] ?? "Unknown",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("#$current of $total", style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(),
            Text("Blood Type: ${data['bloodType'] ?? "N/A"}"),
            Text("Submitted: ${data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate().toString().split(' ')[0] : 'Unknown'}"),
            const SizedBox(height: 12),
            const Text("• ID: verified_id.jpg"),
            const Text("• Selfie: selfie.jpg"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateStatus(context, doc.id, 'Available'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Approve", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateStatus(context, doc.id, 'Rejected'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Reject", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateStatus(BuildContext context, String docId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('donors')
          .doc(docId)
          .update({'status': newStatus});
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Donor $newStatus")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }
}