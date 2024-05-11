import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class MagentBottomSheetView extends GetView<MainController> {
  const MagentBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.3,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Create',
            style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
          ),
          SizedBox(height: screenHeight * 0.01),
         
          _buildListTile(
            context,
            icon: Icons.campaign,
            title: 'Create campaign',
            onTap: () {
              Navigator.pop(context);
              controller.showMyDialog(context);
            }
          ),
          
          const Divider(),
          _buildListTile(
            context,
            icon: Icons.account_box,
            title: 'Create contact',
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.ADD_CONTACT);
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
