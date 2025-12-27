import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitor_management_app/data/datasources/auth_service.dart';
import 'package:visitor_management_app/presentation/pages/login_page.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        userEmail.value = user.email ?? 'N/A';
      } else {
        userEmail.value = 'N/A';
      }
    });
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAll(() => const LoginPage()); // Navigate back to Login Screen
  }
}

