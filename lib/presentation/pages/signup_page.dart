import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_management_app/presentation/controllers/signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
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
                onPressed: controller.isLoading.value ? null : controller.register,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement Sign up with Google
              },
              child: const Text('Sign Up with Google'),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Navigate back to login screen
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

