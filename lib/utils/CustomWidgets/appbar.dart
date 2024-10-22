import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';

import '../../Constants/color_constants.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String name;
  final String icon;

  const CustomSliverAppBar({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.transparent,
      floating: false,
      pinned: false,
      toolbarHeight: 85,
      leading: Builder(
        builder: (BuildContext context) {
          return Tooltip(
              message: 'Drawer',
              showDuration: const Duration(milliseconds: 400),
              textStyle: const TextStyle(color: white),
              decoration: BoxDecoration(
                color: purple, // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),

              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Opens the drawer
                },

                icon: SvgPicture.asset(
                  "assets/icons/drawer.svg",
                  height: 20,
                  width: 25,
                ))
          );
        },
      ),
      flexibleSpace: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff872BE1).withOpacity(0.0),
                const Color(0xff872be2).withOpacity(0.5),
              ],
              stops: const [0.5, 1.0], // Use 1.0 instead of 100 for proper gradient
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Row(
            children: [
              SvgPicture.asset(icon, height: 20,),


              const SizedBox(width: 15), // Space between icon and text
              Text(
                name,
                style: const TextStyle(
                  color: white,
                  fontSize: headlinesmall, // Use your constant for headline small
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
