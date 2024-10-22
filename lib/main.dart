import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';
import 'package:tradingapp_bot/src/screens/dashboard/main/main_screen.dart';

import 'constants/color_constants.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    if (kDebugMode) {
      print('Caught error: $error');
    }
    if (kDebugMode) {
      print('Stack trace: $stack');


    }
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        //initialBinding: AppBinding(),
      theme: ThemeData(

        textTheme: const TextTheme(bodyMedium: TextStyle(color: white, fontSize: bodymedium, fontWeight: FontWeight.w400)).apply(
          bodyColor: white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const MainScreen()
    );
  }
}

