import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_management_app/presentation/controllers/forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            Obx(() => controller.errorMessage.value.isNotEmpty
                ? Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 16.0),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.sendResetEmail,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Send Reset Email'),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.back(); // Navigate back to login screen
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

