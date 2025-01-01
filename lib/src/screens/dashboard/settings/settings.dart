import 'package:flutter/material.dart';
import 'package:tradingapp_bot/constants/color_constants.dart';
import 'package:tradingapp_bot/src/screens/dashboard/settings/current_account.dart';

import '../../../../Constants/font_size.dart';
import '../../../../constants/padding.dart';
import '../../../../utils/CustomWidgets/appbar.dart';
import '../../dashboard_screen.dart';
import 'add_new_account.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _contenchange = true;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          // Your image file path
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: transparent,
          drawer: const DrawerMain(),
          body: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(
                name: "Settings",
                icon: "assets/icons/settings.svg",
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: globalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _contenchange =
                                      true; // Select the first button
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    gradient: _contenchange
                                        ? buttonlineargradient()
                                        : null, // No gradient when not selected
                                    color: _contenchange
                                        ? null
                                        : transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: _contenchange
                                        ? null
                                        : Border.all(
                                            width: 1,
                                            color: const Color(0xff8A2BE2))),
                                child: const Center(
                                  child: Text(
                                    "Current Account",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: bodymedium,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _contenchange =
                                      false; // Select the second button
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    gradient: !_contenchange
                                        ? buttonlineargradient()
                                        : null, // No gradient when not selected
                                    color: !_contenchange
                                        ? null
                                        : transparent, // Fallback to solid color
                                    borderRadius: BorderRadius.circular(10),
                                    border: _contenchange
                                        ? Border.all(
                                            width: 1,
                                            color: const Color(0xff8A2BE2))
                                        : null),
                                child: const Center(
                                  child: Text(
                                    "Add New Account",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: bodymedium,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _contenchange
                          ? const CurrentAccountScreen()
                          : const AddNewAccountScreen(),
                    ],
                  ),
                ),
              ),
            ],
          ),


      ),
    );
  }
}



