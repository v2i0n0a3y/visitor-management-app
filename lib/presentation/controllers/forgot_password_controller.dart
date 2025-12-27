import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management_app/data/datasources/auth_service.dart';

import '../pages/otp_verification_page.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  Future<void> sendResetEmail() async {
    try {
      isLoading(true);
      errorMessage('');
      successMessage('');
      await _authService.sendPasswordResetEmail(emailController.text);
      Get.to(() => const OtpVerificationPage()); // Navigate to OTP Verification Page
      emailController.clear();
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
    super.onClose();
  }
}

