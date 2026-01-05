import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management_app/data/datasources/auth_service.dart';
import 'package:visitor_management_app/presentation/pages/main_layout_page.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

Future<void> signIn() async {
  try {
    isLoading(true);
    errorMessage('');

    User? user = await _authService.signInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (user != null) {
      Get.offAll(() => const MainLayoutPage());
    } else {
      errorMessage("Login failed. Please check your credentials.");
    }
  } catch (e) {
    errorMessage(e.toString());
    print(e.toString());
  } finally {
    isLoading(false);
  }
}

  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      errorMessage('');
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        Get.offAll(() => const MainLayoutPage()); // Navigate to home screen
      } else {
        errorMessage("Google Sign-In failed. Please try again.");
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
    super.onClose();
  }
}

