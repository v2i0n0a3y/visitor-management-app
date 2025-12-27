import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/usecases/get_visitors.dart';
import 'package:visitor_management_app/domain/usecases/update_visitor.dart';

class VisitorListController extends GetxController {
  final GetVisitors _getVisitors = Get.find<GetVisitors>();
  final UpdateVisitor _updateVisitor = Get.find<UpdateVisitor>(); // Added
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var allVisitors = <Visitor>[].obs;
  var visitorsInBuilding = <Visitor>[].obs;
  var visitorsWhoReturned = <Visitor>[].obs;
  var isLoading = false.obs;
  var selectedTabIndex = 0.obs;

  User? currentUser;

  @override
  void onInit() {
    super.onInit();
    currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      fetchVisitors();
    }
  }

  void fetchVisitors() {
    if (currentUser?.email == null) return;
    isLoading(true);
    _getVisitors.call(currentUser!.email!).listen((visitors) {
      allVisitors.assignAll(visitors);
      visitorsInBuilding.assignAll(visitors.where((v) => !v.hasReturned).toList());
      visitorsWhoReturned.assignAll(visitors.where((v) => v.hasReturned).toList());
      isLoading(false);
    });
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> markVisitorAsReturned(Visitor visitor) async {
    if (!visitor.hasReturned) {
      final updatedVisitor = visitor.copyWith(hasReturned: true, timeToLeave: DateTime.now());
      await _updateVisitor.call(updatedVisitor);
      Get.snackbar('Success', 'Visitor ${visitor.fullName} marked as returned.');
    }
  }
}

