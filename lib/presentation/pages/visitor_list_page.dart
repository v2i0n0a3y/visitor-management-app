import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_management_app/presentation/controllers/visitor_list_controller.dart';
import 'package:visitor_management_app/presentation/pages/visitor_details_page.dart';
import 'package:visitor_management_app/presentation/controllers/visitor_details_controller.dart';
import '../../domain/entities/visitor.dart';

class VisitorListPage extends GetView<VisitorListController> {
  const VisitorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Visitors List'),
          bottom: TabBar(
            onTap: controller.changeTab,
            tabs: const [
              Tab(text: 'All Visitors'),
              Tab(text: 'In Building'),
              Tab(text: 'Returned'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: [
              _buildVisitorList(controller.allVisitors),
              _buildVisitorList(controller.visitorsInBuilding),
              _buildVisitorList(controller.visitorsWhoReturned),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildVisitorList(RxList<Visitor> visitors) {
    if (visitors.isEmpty) {
      return const Center(child: Text('No visitors to display.'));
    }
    return ListView.builder(
      itemCount: visitors.length,
      itemBuilder: (context, index) {
        final visitor = visitors[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(visitor.photoUrl ?? 'https://www.gravatar.com/avatar/?d=mp'),
            ),
            title: Text(visitor.fullName),
            subtitle: Text(visitor.mobileNumber),
            trailing: (controller.selectedTabIndex.value == 0 || controller.selectedTabIndex.value == 1) && !visitor.hasReturned
                ? IconButton(
                    icon: const Icon(Icons.outbond),
                    onPressed: () => controller.markVisitorAsReturned(visitor),
                  )
                : null,
            onTap: () {
              Get.to(() => VisitorDetailsPage(), binding: BindingsBuilder(() {
                Get.put(VisitorDetailsController(visitor.obs));
              }));
            },
          ),
        );
      },
    );
  }
}

