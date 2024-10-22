import 'package:flutter/material.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';
import 'package:tradingapp_bot/src/screens/dashboard_screen.dart';

import '../../../../constants/font_size.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Builder(
            builder: (BuildContext context) {
              return Tooltip(
                message: 'Drawer',
                showDuration: const Duration(milliseconds: 800),
                textStyle: const TextStyle(color: white),
                decoration: BoxDecoration(
                  color: purple, // Background color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Opens the drawer
                  },
                ),
              );
            },
          ),
        ),
        drawer: const DrawerMain(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: background,
                  elevation: 5,
                  shadowColor: background,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 200, // Adjust the width as needed
                        height: 200, // Adjust the height as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primarycolor, // Border color
                            width: 4, // Border width
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 100,
                          // Adjust the radius to fit inside the Container
                          backgroundImage:
                              AssetImage('assets/images/aboutpic.jpg'), // Image
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Text(
                          "Ultimate Bot",
                          style: TextStyle(
                              fontSize: titlelarge,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
