import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/repositories/bot/stop_bot_repo.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';
import '../socket/socket_controller_new.dart';
final socketController = Get.find<SocketController>();

class StopBotController extends GetxController {
  final StopBotRepository stopBotRepository;

  StopBotController(this.stopBotRepository);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Method to handle login
  Future<void> botStop({
    required String accountId,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await stopBotRepository.stopBot(accountId: accountId);


      if (kDebugMode) {
        print('Stop Bot successful: $response');
      }

      Get.snackbar(
        'Successful',
        '${response['message']}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        backgroundColor: purple,
        colorText: white,
      );
      socketController.disconnect();
    } catch (error) {
      errorMessage.value = error.toString();

      if (kDebugMode) {
        print('Stop Bot failed controller: $error\n');
      }

      ErrorHandler.handle(
        error,
        defaultErrorMessage: 'Failed to Stop Bot. Please try again.',

      );
    } finally {
      isLoading.value = false;
      if (kDebugMode) {
        print('Loading status: $isLoading');
      }
      if (kDebugMode) {
        print('//////////////////////////////////////');
      }
    }
  }






}
