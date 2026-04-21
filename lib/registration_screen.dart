import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added for proper user ID management

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController lastDonationController = TextEditingController();

  String? selectedBloodType;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    lastDonationController.dispose();
    super.dispose();
  }

  Future<void> _registerDonor() async {
    try {
      // 1. Create the user in Firebase Authentication first
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      // 2. Save to 'users' collection (This controls the Dashboard/Permissions)
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': 'donor', // New signups are donors by default
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. Save to 'donors' collection (This stores the medical data)
      await FirebaseFirestore.instance.collection('donors').doc(uid).set({
        'uid': uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'bloodType': selectedBloodType,
        'lastDonation': lastDonationController.text,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, "/home");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration failed: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Donor Registration"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedBloodType,
              items: [
                "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-",
              ].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
              onChanged: (v) {
                setState(() => selectedBloodType = v);
              },
              decoration: const InputDecoration(labelText: "Blood Type"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastDonationController,
              decoration: const InputDecoration(
                labelText: "Last Donation Date",
                hintText: "Tap to select date",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    lastDonationController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: const Text("Upload ID Document"),
              onPressed: () {}, 
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: const Text("Upload Selfie"),
              onPressed: () {}, 
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Submit"),
              onPressed: () {
                if (nameController.text.isEmpty || 
                    emailController.text.isEmpty || 
                    phoneController.text.isEmpty || 
                    selectedBloodType == null ||
                    passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields (Password min 6 chars)")),
                  );
                  return;
                }
                _registerDonor();
              },
            ),
          ],
        ),
      ),
    );
  }
}