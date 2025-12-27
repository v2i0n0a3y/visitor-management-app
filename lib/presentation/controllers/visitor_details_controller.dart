import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/usecases/update_visitor.dart';

class VisitorDetailsController extends GetxController {
  final UpdateVisitor _updateVisitor = Get.find<UpdateVisitor>();

  final Rx<Visitor> visitor;

  VisitorDetailsController(this.visitor);

  void markAsReturned() async {
    if (!visitor.value.hasReturned) {
      final updatedVisitor = visitor.value.copyWith(hasReturned: true, timeToLeave: DateTime.now());
      await _updateVisitor.call(updatedVisitor);
      visitor.value = updatedVisitor; // Update the observable visitor
      Get.back(); // Go back to the list after updating
    }
  }

  void callVisitor() async {
    final Uri launchUri = Uri(scheme: 'tel', path: visitor.value.mobileNumber);
    await launchUrl(launchUri);
  }

  String getRemainingTime() {
    if (visitor.value.timeToLeave == null) {
      return 'N/A';
    }
    final duration = visitor.value.timeToLeave!.difference(DateTime.now());
    if (duration.isNegative) {
      return 'Time elapsed';
    } else if (duration.inDays > 0) {
      return '${duration.inDays} days';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hours';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minutes';
    } else {
      return '${duration.inSeconds} seconds';
    }
  }
}

