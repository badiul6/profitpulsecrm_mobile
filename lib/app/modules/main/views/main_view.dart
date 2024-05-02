import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/owner_bottom_sheet_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/owner_drawer_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.primary,
        title: Text(
          'Home',
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      drawer: const OwnerDrawerView(),
      body: const Center(
        child: Text(
          'MainView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.025),
        child: Container(
          width: screenWidth * 0.53,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(color: colorScheme.onSurface),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print('menu');
                  controller.scaffoldKey.currentState?.openDrawer();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 30,
                      color: colorScheme.onSurface, // Apply color from theme
                    ),
                    Text('Menu', style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print('add');
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const OwnerBottomSheetView();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    minimumSize: Size(double.minPositive, screenHeight * 0.065),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.white,
                  )),
              InkWell(
                onTap: () {
                  print('search');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      size: 30,
                      color: colorScheme.onSurface, // Apply color from theme
                    ),
                    Text('Search', style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
