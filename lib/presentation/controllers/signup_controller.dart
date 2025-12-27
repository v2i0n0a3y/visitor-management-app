import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management_app/data/datasources/auth_service.dart';

class SignUpController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage("Passwords do not match.");
      return;
    }

    try {
      isLoading(true);
      errorMessage('');
      User? user = await _authService.registerWithEmailAndPassword(
          emailController.text, passwordController.text);
      if (user != null) {
        Get.snackbar('Success', 'Registration successful. Please login.');
        Get.back(); // Navigate back to login screen
      } else {
        errorMessage("Registration failed. Please try again.");
      }
    } catch (e) {
      errorMessage(e.toString());
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

