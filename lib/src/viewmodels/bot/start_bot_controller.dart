import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/repositories/bot/start_bot_repo.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';
import '../socket/socket_controller.dart';
final socketController = Get.find<SocketController>();

class StartBotController extends GetxController {
  final StartBotRepository startBotRepository;

  StartBotController(this.startBotRepository);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Method to handle login
  Future<void> botStart() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await startBotRepository.startBot();


      if (kDebugMode) {
        print('Start Bot successful: $response');

      }


      Get.snackbar(
        'Successful',
        '${response['message']}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        backgroundColor: purple,
        colorText: white,
      );
      socketController.connect();

      if (socketController.socket?.connected == false) {
        socketController.connect();
      } else {
        if (kDebugMode) {
          print('Socket is already connected.');
        }
      }
    } catch (error) {
      errorMessage.value = error.toString();

      if (kDebugMode) {
        print('Start Bot failed controller: $error\n');
      }

      ErrorHandler.handle(
        error,
        defaultErrorMessage: 'Failed to Start Bot. Please try again.',
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
