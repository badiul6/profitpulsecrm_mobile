import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerDrawerView extends GetView {
  const OwnerDrawerView({super.key});

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
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      minRadius: 30,
                      backgroundImage: AssetImage('assets/images/p.jpg'),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        'DHL Logistics',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.background),
                            overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
                Text.rich(
                  
                  TextSpan(
                      text: 'Abdul Rahman: ',
                      
                      style: TextStyle(color: colorScheme.background),
                      children: [
                        TextSpan(
                            text: 'Owner',
                            style: TextStyle(color: colorScheme.background)),
                      ]),
                      overflow: TextOverflow.ellipsis,
                ),

                Text(
                  'abdul.rahman10023@gmail.com',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: colorScheme.background),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
            
              color: colorScheme.background,
              child: Column(children: [
                buildListTile(
                    'Dashboard', true, context, colorScheme), // Selected
                buildListTile(
                    'Profile', false, context, colorScheme), // Not selected
                buildListTile('Settings', false, context, colorScheme),
              ]),
            ),
          )
          // Add more items as needed
        ],
      ),
    );
  }

  Widget buildListTile(String title, bool isSelected, BuildContext context,
      ColorScheme colorScheme) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 15,
            // color: isSelected
            //     ? colorScheme.background
            //     : Colors.transparent, // Adjusted per selection
          ),
          Expanded(
            child: ListTile(
              // selected: isSelected,
              // selectedTileColor: colorScheme.secondaryContainer,
              title: Text(title,
                  style: TextStyle(color: colorScheme.onSecondaryContainer)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ),
        ],
      ),
    );
  }
}
