import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visitor_management_app/presentation/controllers/visitor_details_controller.dart';

class VisitorDetailsPage extends GetView<VisitorDetailsController> {
  const VisitorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Details')),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(controller.visitor.value.photoUrl ?? 'https://www.gravatar.com/avatar/?d=mp'),
                ),
              ),
              const SizedBox(height: 16.0),
              _buildDetailRow('Full Name:', controller.visitor.value.fullName),
              _buildDetailRow('Mobile Number:', controller.visitor.value.mobileNumber),
              _buildDetailRow('Email ID:', controller.visitor.value.emailId ?? 'N/A'),
              _buildDetailRow('Purpose of Visit:', controller.visitor.value.purposeOfVisit),
              _buildDetailRow('Company Name:', controller.visitor.value.companyName),
              _buildDetailRow('Person to Visit:', controller.visitor.value.personToVisit),
              _buildDetailRow(
                'Time to Meet:',
                DateFormat('yyyy-MM-dd hh:mm a').format(controller.visitor.value.timeToMeet),
              ),
              _buildDetailRow(
                'Time to Leave:',
                controller.visitor.value.timeToLeave == null
                    ? 'N/A'
                    : DateFormat('yyyy-MM-dd hh:mm a').format(controller.visitor.value.timeToLeave!),
              ),
              _buildDetailRow('Status:', controller.visitor.value.hasReturned ? 'Returned' : 'In Building'),
              _buildDetailRow('Watchman Email:', controller.visitor.value.watchmanEmail),
              const SizedBox(height: 16.0),
              Text(
                'Remaining Time: ${controller.getRemainingTime()}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              if (!controller.visitor.value.hasReturned)
                ElevatedButton(
                  onPressed: controller.markAsReturned,
                  child: const Text('Mark as Returned'),
                ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: controller.callVisitor,
                child: const Text('Call Visitor'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

