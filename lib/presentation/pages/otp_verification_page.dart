import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A password reset link has been sent to your registered email address. Please check your inbox and follow the instructions to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/'); // Navigate back to Login Screen (or initial route)
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

