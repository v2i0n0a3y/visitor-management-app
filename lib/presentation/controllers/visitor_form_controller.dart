import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/usecases/add_visitor.dart';
import 'package:visitor_management_app/presentation/controllers/main_layout_controller.dart';

class VisitorFormController extends GetxController {
  final AddVisitor _addVisitor = Get.find<AddVisitor>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailIdController = TextEditingController();
  final purposeOfVisitController = TextEditingController();
  final companyNameController = TextEditingController();
  final personToVisitController = TextEditingController();

  var selectedTimeToMeet = Rx<DateTime?>(null);
  var selectedTimeToLeave = Rx<DateTime?>(null);
  var photoUrl = Rx<String?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      isLoading(true);
      try {
        final ref = _firebaseStorage.ref().child('visitor_photos').child('${DateTime.now().toIso8601String()}.jpg');
        await ref.putData(await image.readAsBytes());
        photoUrl.value = await ref.getDownloadURL();
      } catch (e) {
        errorMessage(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> selectTimeToMeet(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      selectedTimeToMeet.value = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }

  Future<void> selectTimeToLeave(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      selectedTimeToLeave.value = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }

  Future<void> submitVisitor() async {
    if (fullNameController.text.isEmpty ||
        mobileNumberController.text.isEmpty ||
        purposeOfVisitController.text.isEmpty ||
        companyNameController.text.isEmpty ||
        personToVisitController.text.isEmpty ||
        selectedTimeToMeet.value == null) {
      errorMessage("Please fill all required fields.");
      return;
    }

    try {
      isLoading(true);
      errorMessage('');
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null || currentUser.email == null) {
        errorMessage("User not logged in.");
        return;
      }

      final visitor = Visitor(
        photoUrl: photoUrl.value,
        fullName: fullNameController.text,
        mobileNumber: mobileNumberController.text,
        emailId: emailIdController.text.isEmpty ? null : emailIdController.text,
        purposeOfVisit: purposeOfVisitController.text,
        companyName: companyNameController.text,
        personToVisit: personToVisitController.text,
        timeToMeet: selectedTimeToMeet.value!,
        timeToLeave: selectedTimeToLeave.value,
        watchmanEmail: currentUser.email!,
      );

      await _addVisitor.call(visitor);
      Get.snackbar('Success', 'Visitor added successfully!');
      clearForm();
      Get.find<MainLayoutController>().changePage(0); // Navigate to Visitors List
    } catch (e) {
      errorMessage(e.toString());
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    fullNameController.clear();
    mobileNumberController.clear();
    emailIdController.clear();
    purposeOfVisitController.clear();
    companyNameController.clear();
    personToVisitController.clear();
    selectedTimeToMeet.value = null;
    selectedTimeToLeave.value = null;
    photoUrl.value = null;
    errorMessage('');
  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    emailIdController.dispose();
    purposeOfVisitController.dispose();
    companyNameController.dispose();
    personToVisitController.dispose();
    super.onClose();
  }
}

