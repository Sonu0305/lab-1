import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Profile Avatar
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueGrey,
                backgroundImage: const AssetImage(
                  'assets/pfp_for_superset.jpg',
                ),
              ),
              // Profile image ends here
              const SizedBox(height: 16),
              // Name
              Text(
                'Swayam Kalpesh Shah', // <-- CHANGE to your name
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 20),
              // Info Card Container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoRow('Roll No.', '231070062'),  // <-- CHANGE
                    const Divider(),
                    _buildInfoRow('Year', 'Final Year'),        // <-- CHANGE
                    const Divider(),
                    _buildInfoRow('Branch', 'Computer Engineering'),    // <-- CHANGE
                    const Divider(),
                    _buildInfoRow('Semester', 'VII'), // <-- CHANGE
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Elevated Button
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile details verified!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build a label-value row
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}