import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class OwnerBottomSheetView extends GetView<MainController> {
  const OwnerBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.5,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Create',
            style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton(
                context,
                icon: Icons.person_add,
                text: 'User',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.ADD_USER);
                }
              ),
              _buildIconButton(
                context,
                icon: Icons.account_box,
                text: 'Contact',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.ADD_CONTACT);
                }
              ),
              _buildIconButton(
                context,
                icon: Icons.handshake_rounded,
                text: 'Deal',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.ADD_DEAL);
                }
              ),
              _buildIconButton(
                context,
                icon: Icons.note_alt,
                text: 'Ticket',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.ADD_TICKET);
                }
              ),
            ],
          ),
          const Divider(),
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
            icon: Icons.assignment_ind,
            title: 'Assign agent',
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.ASSIGN_AGENT);
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
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 18, color: colorScheme.error),
            )
          )
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.primary)
            ),
            child: Icon(icon, size: 25, color: colorScheme.primary),
          ),
          Text(text, style: TextStyle(fontSize: 16, color: colorScheme.onSurface))
        ],
      )
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
