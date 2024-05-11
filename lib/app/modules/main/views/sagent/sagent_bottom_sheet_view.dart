import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class SagentBottomSheetView extends GetView<MainController> {
  const SagentBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.32,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Create',
            style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
          ),
         const Divider(),
          _buildListTile(
            context,
            icon: Icons.account_box,
            title: 'Add Contact',
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.ADD_CONTACT);
            }
          ),
          const Divider(),
          _buildListTile(
            context,
            icon: Icons.sell,
            title: 'Add a sale',
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.ADD_SALE);
            }
          ),
          const Divider(),
          SizedBox(height: screenHeight * 0.015),
          Center(
              child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 18, color: colorScheme.error),
            ),
          ))
        ],
      ),
    );
  }

 
  Widget _buildListTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
    );
  }
}
