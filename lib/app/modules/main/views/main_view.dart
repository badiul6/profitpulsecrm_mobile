import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/csagent/csagent_bottom_sheet_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/csagent/csagent_drawer_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/csagent/csagent_home_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/magent/magent_bottom_sheet_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/magent/magent_drawer_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/magent/magent_home_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/owner_bottom_sheet_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/owner_drawer_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/owner_home_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/sagent/sagent_bottom_sheet_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/sagent/sagent_drawer_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/sagent/sagent_home_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/shead/shead_bottom_sheet_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/shead/shead_drawer_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/shead/shead_home_view.dart';
import 'package:shimmer/shimmer.dart';

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
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomSheetViewByRole(controller.role.value);
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
        title: Text(
          'Home',
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      drawer: Obx(() => _buildDrawerViewByRole(controller.role.value)),
      body: Obx(() => (controller.isPageLoading.value)
          ? ListView(
              children: [
                const SizedBox(height: 20),
                buildCampaignShimmer(screenWidth, screenHeight),
                buildProductShimmer(screenWidth, screenHeight),
                buildCampaignShimmer(screenWidth, screenHeight),
                buildProductShimmer(screenWidth, screenHeight),
                buildCampaignShimmer(screenWidth, screenHeight),
                buildProductShimmer(screenWidth, screenHeight),
              ],
            )
          : _buildHomeViewByRole(controller.role.value)),
    );
  }

  Widget _buildHomeViewByRole(String role) {
    switch (role) {
      case 'OWNER':
        return OwnerHomeView();
      case 'SHEAD':
        return SheadHomeView();
      case 'MAGENT':
        return MagentHomeView(); // Assuming you have a MagentHomeView
      case 'SAGENT':
        return SagentHomeView(); // Assuming you have a SagentHomeView
      case 'CSAGENT':
        return CsagentHomeView(); // Assuming you have a CsagentHomeView
      default:
        return Container();
    }
  }

  Widget _buildBottomSheetViewByRole(String role) {
    switch (role) {
      case 'OWNER':
        return const OwnerBottomSheetView();
      case 'SHEAD':
        return const SheadBottomSheetView();
      case 'MAGENT':
        return const MagentBottomSheetView(); // Assuming you have a MagentHomeView
      case 'SAGENT':
        return const SagentBottomSheetView(); // Assuming you have a SagentHomeView
      case 'CSAGENT':
        return const CsagentBottomSheetView(); // Assuming you have a CsagentHomeView
      default:
        return Container();
    }
  }

  Widget _buildDrawerViewByRole(String role) {
    switch (role) {
      case 'OWNER':
        return const OwnerDrawerView();
      case 'SHEAD':
        return const SheadDrawerView();
      case 'MAGENT':
        return const MagentDrawerView(); // Assuming you have a MagentHomeView
      case 'SAGENT':
        return const SagentDrawerView(); // Assuming you have a SagentHomeView
      case 'CSAGENT':
        return const CsagentDrawerView(); // Assuming you have a CsagentHomeView
      default:
        return Container();
    }
  }

  Widget buildProductShimmer(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.225,
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[350]!, // Slightly darker base color
        highlightColor: Colors.grey[100]!, // Very light highlight color
        period: const Duration(milliseconds: 1500), // Slower shimmer effect
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 50, height: 10, color: Colors.white),
                  Container(width: 100, height: 10, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCampaignShimmer(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.08,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[300]!,
          ],
          stops: const [0.1, 0.5, 0.9],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.02,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.02,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
