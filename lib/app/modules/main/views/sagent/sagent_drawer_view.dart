import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class SagentDrawerView extends GetView<MainController> {
  const SagentDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colorScheme.primary,
      width: screenWidth * 0.64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: screenHeight * 0.060,
                bottom: screenHeight * 0.02,
                left: screenWidth * 0.020),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(() => CircleAvatar(
                      minRadius: 30,
                      backgroundImage:controller.profile.value!=null? MemoryImage(base64Decode(controller.profile.value!.logo)):null,
                    ),),
                    SizedBox(width: screenWidth * 0.02),
                     Expanded(
                      child: Obx(() => Text(
                        controller.profile.value?.companyName ?? "N/A" ,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.background),
                        overflow: TextOverflow.ellipsis,
                      ),)
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
                Obx(() => Text.rich(
                  TextSpan(
                      text: "${controller.profile.value?.userName ?? "N/A"}: " ,
                      style: TextStyle(color: colorScheme.background),
                      children: [
                        TextSpan(
                            text: controller.profile.value?.role ?? "N/A" ,
                            style: TextStyle(color: colorScheme.background)),
                      ]),
                  overflow: TextOverflow.ellipsis,
                ),),
                 Obx(() => Text(
                  controller.profile.value?.companyEmail ?? "N/A" ,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: colorScheme.background),
                ),)
              ],
            ),
          ),
          Container(
            color: colorScheme.background,
            height: screenHeight*0.006,
),
          Expanded(
            child: Obx(() => Container(
                  color: colorScheme.background,
                  child: Column(children: [
                    buildListTile(
                      title: 'Home',
                      context: context,
                      colorScheme: colorScheme,
                      icon: const Icon(Icons.home),
                      onTapCallback: () {
                        Navigator.pop(context);
                      },
                    ),
                    buildListTile(
                        title: 'Contacts',
                        context: context,
                        colorScheme: colorScheme,
                        icon: const Icon(Icons.people),
                        onTapCallback: () {
                          Navigator.pop(context);
                          Get.toNamed(Routes.SEARCH_CONTACT);
                        }),
                     
                        buildListTile(
                        title: 'Products',
                        context: context,
                        colorScheme: colorScheme,
                        icon: const Icon(Icons.business_center),
                        onTapCallback: () {
                                                  Navigator.pop(context);

                          Get.toNamed(Routes.SEARCH_PRODUCT);
                        }),
                        buildListTile(
                        title: 'Deals',
                        context: context,
                        colorScheme: colorScheme,
                        icon: const Icon(Icons.handshake),
                        onTapCallback: () {
                                                  Navigator.pop(context);

                          Get.toNamed(Routes.SEARCH_AGENT_DEAL);
                        }),
                       
                    
                    Expanded(
                        child: Container(
                      color: colorScheme.background,
                    )),
                    Divider(
                      color: colorScheme.onBackground,
                    ),
                    InkWell(
                      onTap: () {
                        controller.logout();
                      },
                      child: Container(
                        margin: EdgeInsets.zero,
                        color: colorScheme.background,
                        child: ListTile(
                          horizontalTitleGap: 10,
                          contentPadding: EdgeInsets.only(
                              left: screenWidth * 0.10,
                              bottom: screenHeight * 0.01,
                              top: screenHeight * 0),
                          leading: Icon(
                            Icons.logout,
                            size: 28,
                            color: colorScheme.onBackground,
                          ),
                          title: Text(
                            'Log out',
                            style: TextStyle(
                                fontSize: 18, color: colorScheme.onBackground),
                          ),
                        ),
                      ),
                    )
                  ]),
                )),
          )
        ],
      ),
    );
  }

  Widget buildListTile(
      {required String title,
      required BuildContext context,
      required ColorScheme colorScheme,
      required Icon icon,
      required VoidCallback onTapCallback}) {
    bool isSelected = controller.currentMenu.value == title;
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 07,
            color: isSelected
                ? colorScheme.primary
                : colorScheme.background, // Adjusted per selection
          ),
          Expanded(
            child: Container(
              color: isSelected
                  ? colorScheme.primary.withOpacity(0.4)
                  : colorScheme.background,
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 07),
                horizontalTitleGap: 10,
                leading: icon,
                title: Text(
                  title,
                  style: TextStyle(color: colorScheme.onBackground),
                ),
                onTap: onTapCallback,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
