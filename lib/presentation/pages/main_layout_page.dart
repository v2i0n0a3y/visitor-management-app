import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_management_app/presentation/controllers/main_layout_controller.dart';
import 'package:visitor_management_app/presentation/pages/visitor_list_page.dart';
import 'package:visitor_management_app/presentation/pages/visitor_form_page.dart';
import 'package:visitor_management_app/presentation/pages/profile_page.dart';

class MainLayoutPage extends GetView<MainLayoutController> {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: const [
          VisitorListPage(), // Visitors List Screen
          VisitorFormPage(), // Visitor Form Screen
          ProfilePage(), // Profile Screen
        ],
      )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Visitors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Add Visitor',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

