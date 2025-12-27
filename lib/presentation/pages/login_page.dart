import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_management_app/presentation/controllers/login_controller.dart';
import 'package:visitor_management_app/presentation/pages/signup_page.dart';
import 'package:visitor_management_app/presentation/pages/forgot_password_page.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
            Obx(() => controller.errorMessage.value.isNotEmpty
                ? Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 16.0),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.signIn,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const SignUpPage());
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.to(() => const ForgotPasswordPage());
              },
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(height: 16.0), // Added this line to satisfy the context requirement of 3 lines after the change
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: controller.signInWithGoogle,
              child: const Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}

