import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';
import '../../data/repositories/accounts/delete_account_repo.dart';



class DeleteAccountController extends GetxController {
  final DeleteAccountRepository deleteAccountRepository;

  DeleteAccountController(this.deleteAccountRepository);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;




  // Method to handle login
  Future<void> deleteAccountId(
      {
        required String accountId,
      }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response =   await deleteAccountRepository.deleteAccountRepo(accountId: accountId);


      if (kDebugMode) {
        print('Delete Account successful: $response');
      }

      Get.snackbar(
        'Successful',
        '${response['message']}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        backgroundColor: purple,
        colorText: white,
      );


    } catch (e) {
      ErrorHandler.handle(
        e,
        defaultErrorMessage: 'Failed to delete account. Please try again.',
      );


      if (kDebugMode) {
        print('Delete Account failed controller: $e');
      }

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
