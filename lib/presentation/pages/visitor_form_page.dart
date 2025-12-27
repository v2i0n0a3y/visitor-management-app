import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visitor_management_app/presentation/controllers/visitor_form_controller.dart';

class VisitorFormPage extends GetView<VisitorFormController> {
  const VisitorFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Visitor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => controller.photoUrl.value == null
                  ? ElevatedButton(
                      onPressed: controller.pickImage,
                      child: const Text('Pick Visitor Photo'),
                    )
                  : Column(
                      children: [
                        Image.network(controller.photoUrl.value!,
                            height: 150, width: 150, fit: BoxFit.cover),
                        TextButton(
                            onPressed: controller.pickImage,
                            child: const Text('Change Photo'))
                      ],
                    )),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.mobileNumberController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.emailIdController,
                decoration: const InputDecoration(
                  labelText: 'Email ID (Optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.purposeOfVisitController,
                decoration: const InputDecoration(
                  labelText: 'Purpose of Visit',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.companyNameController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.personToVisitController,
                decoration: const InputDecoration(
                  labelText: 'Name of Person to Visit',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => controller.selectTimeToMeet(context),
                child: Obx(
                  () => InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Time to Meet',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      controller.selectedTimeToMeet.value == null
                          ? 'Select Time'
                          : DateFormat('hh:mm a').format(controller.selectedTimeToMeet.value!),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => controller.selectTimeToLeave(context),
                child: Obx(
                  () => InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Time to Leave (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      controller.selectedTimeToLeave.value == null
                          ? 'Select Time'
                          : DateFormat('hh:mm a').format(controller.selectedTimeToLeave.value!),
                    ),
                  ),
                ),
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
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitVisitor,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit Visitor'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

