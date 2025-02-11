import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo/Icon
            const Icon(
              Icons.local_hospital,
              size: 60,
              color: Colors.pink,
            ),
            const SizedBox(height: 15),

            // App Name
            const Text(
              'ClinicLink',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Description
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'ClinicLink is dedicated to enhancing healthcare accessibility for seniors by providing a seamless clinic appointment booking experience. Our app connects users with nearby clinics, offering real-time availability and reminders to ensure stress-free healthcare management.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Info
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      '📞 Contact No: +65 9185 1933',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '✉️ Email: contact@cliniclink.sg',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
