import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constants.dart';
import 'exception.dart';

class ErrorHandler {
  static final Map<int, String> defaultStatusMessages = {
    400: 'Invalid request. Please check your input.',
    401: 'Unauthorized. Please log in again.',
    403: 'Access denied. You don\'t have permission for this action.',
    404: 'Resource not found.',
    408: 'Request timeout. Please try again',
    500: 'Server error. Please try again later.',
    502: 'Service temporarily unavailable. Please try again later.',
  };


  static void handle(dynamic error, {
    String? defaultErrorMessage,
    Map<int, String>? statusMessages,
  }) {
    if (error is ApiException) {
      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('API Exception Details:');
        print('Status Code: ${error.statusCode}');
        print('Details: ${error.details}');
        print('Message: ${error.message}');
        print('//////////////////////////////////////');
      }

      final combinedStatusMessages = {
        ...defaultStatusMessages,
        if (statusMessages != null) ...statusMessages
      };

      // Use error details if available, otherwise fallback to status message or error message
      final message = error.message ;  // Use empty string if message is null
      final statusMessage = combinedStatusMessages[error.statusCode];
      final fallbackMessage = defaultErrorMessage ?? 'An unexpected error occurred.';
      //String details = error.details ?? 'No additional details';


      // Remove any existing snackbars before showing new one
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }

      ErrorPresenter.showError(
        'Error',
        message,
        statusMessage ?? fallbackMessage,
      );
    } else {
      if (kDebugMode) {
        print('Unexpected error: $error');
      }

      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }

      ErrorPresenter.showError("Error", defaultErrorMessage ??
          'An unexpected error occurred. ','Please try again.');
    }
  }
}


class ErrorPresenter {
  static void showError(String title, String message,String message2,
      {Color? color, String? details}) {
    // Replace Get.snackbar with a custom implementation if needed
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();

    Get.snackbar(
      title,
      "$message\n$message2",

      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      backgroundColor: color ?? red,
      colorText: white,
      duration: const Duration(seconds: 4),
      isDismissible: true,);

  }
}
