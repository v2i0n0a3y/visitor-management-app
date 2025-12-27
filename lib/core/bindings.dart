import 'package:get/get.dart';
import 'package:visitor_management_app/data/datasources/auth_service.dart';
import 'package:visitor_management_app/data/repositories/firebase_visitor_repository.dart';
import 'package:visitor_management_app/domain/repositories/visitor_repository.dart';
import 'package:visitor_management_app/domain/usecases/get_visitors.dart';
import 'package:visitor_management_app/presentation/controllers/login_controller.dart';
import 'package:visitor_management_app/presentation/controllers/signup_controller.dart';
import 'package:visitor_management_app/presentation/controllers/forgot_password_controller.dart';
import 'package:visitor_management_app/presentation/controllers/main_layout_controller.dart';
import 'package:visitor_management_app/presentation/controllers/visitor_list_controller.dart';
import 'package:visitor_management_app/presentation/controllers/visitor_form_controller.dart';
import 'package:visitor_management_app/presentation/controllers/profile_controller.dart';
import 'package:visitor_management_app/domain/usecases/add_visitor.dart';
import 'package:visitor_management_app/domain/usecases/update_visitor.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());

    // Visitor Management Dependencies
    Get.lazyPut<VisitorRepository>(() => FirebaseVisitorRepository());
    Get.lazyPut<GetVisitors>(() => GetVisitors(Get.find()));
    Get.lazyPut<AddVisitor>(() => AddVisitor(Get.find()));
    Get.lazyPut<UpdateVisitor>(() => UpdateVisitor(Get.find())); // Added UpdateVisitor
    Get.lazyPut<VisitorListController>(() => VisitorListController());
    Get.lazyPut<VisitorFormController>(() => VisitorFormController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

