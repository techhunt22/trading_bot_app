import 'package:get/get.dart';

class BotStateController extends GetxController {
  var isBotRunning = false.obs; // Tracks whether the bot is running or stopped

  void startBot() {
    isBotRunning.value = true;
  }

  void stopBot() {
    isBotRunning.value = false;
  }
}
