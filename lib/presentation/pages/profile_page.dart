import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_management_app/presentation/controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Logged in as:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Obx(
              () => Text(
                controller.userEmail.value,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: controller.signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

