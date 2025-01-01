import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/Constants/font_size.dart';
import 'package:tradingapp_bot/src/bindings/account_bindings.dart';
import 'package:tradingapp_bot/src/data/repositories/bot/start_bot_repo.dart';
import 'package:tradingapp_bot/src/data/repositories/bot/stop_bot_repo.dart';
import 'package:tradingapp_bot/src/screens/dashboard/settings/settings.dart';
import 'package:tradingapp_bot/src/viewmodels/bot/bot_state.dart';
import 'package:tradingapp_bot/src/viewmodels/bot/start_bot_controller.dart';
import 'package:tradingapp_bot/src/viewmodels/bot/stop_bot_controller.dart';
import 'package:tradingapp_bot/src/viewmodels/socket/socket_controller.dart';

import 'constants/color_constants.dart';

void main() {

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(SocketController());
    // Initialize the BotStateController
    Get.put(BotStateController());
    // Initialize other controllers
    Get.put(StartBotController(StartBotRepository()));
    Get.put(StopBotController(StopBotRepository()));
    runApp(
        const MyApp()
    //   DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(), // Wrap your app
    // ),


    );



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
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        
        theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: white
          ),
          scrollbarTheme: ScrollbarThemeData(
            trackColor: WidgetStatePropertyAll(white),
            thumbColor: WidgetStatePropertyAll(white)

          ),
          textTheme: const TextTheme(
                  bodyMedium: TextStyle(
                      color: white,
                      fontSize: bodymedium,
                      fontWeight: FontWeight.w400
                  )).apply(bodyColor: white,),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialBinding:  AccountBinding(),
        home: const SettingsScreen());
  }
}
