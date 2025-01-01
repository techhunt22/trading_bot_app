import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_size.dart';
import 'dashboard/about/about.dart';
import 'dashboard/bot/bot_start_screen.dart';
import 'dashboard/buysellcoins/buy_sell_coins.dart';
import 'dashboard/settings/settings.dart';

class ScreenController extends GetxController {
  var currentScreen =
      'Settings'.obs; // Reactive variable to track the current screen
}

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  final ScreenController screenController =
      Get.put(ScreenController()); // Create and inject the controller

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          // Your image file path
          fit: BoxFit.cover, // Make sure the image covers the entire screen
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          return ListView(
            children: <Widget>[
              Container(
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff872BE1).withOpacity(0.0),
                      const Color(0xff872be2).withOpacity(0.5)
                    ],
                    stops: const [0.5, 100],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: white,
                        iconSize: 30,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // buttonDrawer(
              //     img: "assets/icons/main.svg",
              //     name: "Main",
              //     isSelected: screenController.currentScreen.value == "Main",
              //     ontap: () async {
              //       screenController.currentScreen.value =
              //           "Main"; // Update current screen
              //
              //       Future.delayed(const Duration(milliseconds: 500), () {
              //         Get.back();
              //         Get.off(() => const MainScreen());
              //       });
              //
              //     }),
              //
              // const SizedBox(
              //   height: 20,
              // ),
              //

              // const SizedBox(
              //   height: 20,
              // ),


              buttonDrawer(
                  img: "assets/icons/settings.svg",
                  name: "Settings",
                  isSelected:
                      screenController.currentScreen.value == "Settings",
                  ontap: () async {
                    screenController.currentScreen.value =
                    "Settings"; // Update current screen

                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.back();
                      Get.off(() => const SettingsScreen(),
                      );
                    });

                  }),
              const SizedBox(
                height: 20,
              ),
              buttonDrawer(
                  img: "assets/icons/carticon.svg",
                  name: "Buy and Sell",
                  isSelected: screenController.currentScreen.value == "Buy and Sell",
                  ontap: () async {
                    screenController.currentScreen.value =
                    "Buy and Sell"; // Update current screen

                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.back();
                      Get.off(() => const BuySellCoinsScreen());
                    });

                  }),
              const SizedBox(
                height: 20,
              ),

              buttonDrawer(
                  img: "assets/icons/manual.svg",
                  name: "Bot",
                  isSelected: screenController.currentScreen.value == "Bot",
                  ontap: () async {
                    screenController.currentScreen.value =
                        "Bot"; // Update current screen


                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.back();
                      Get.off(() => const BotStartScreen());
                    });


                  }),

              const SizedBox(
                height: 20,
              ),
              buttonDrawer(
                  img: "assets/icons/about.svg",
                  name: "About",
                  isSelected: screenController.currentScreen.value == "About",
                  ontap: () async {
                    screenController.currentScreen.value =
                        "About"; // Update current screen

                    Future.delayed(const Duration(milliseconds: 500), () {
                      Get.back();
                      Get.off(() => const About());
                    });
                  }),
            ],
          );
        }),
      ),
    );
  }
}

Widget buttonDrawer({
  required String img,
  required VoidCallback ontap,
  required String name,
  required bool isSelected, // New parameter to check if the button is selected
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: GestureDetector(
      onTap: ontap, // Navigate to Main
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      purple.withOpacity(0.5),
                      const Color(0xff4231C8).withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )
                : null,
            color: isSelected ? null : darkbackground,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              img,
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: bodylarge,
                  color: white,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    ),
  );
}
