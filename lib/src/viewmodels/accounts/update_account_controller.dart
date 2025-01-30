import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';
import '../../data/repositories/accounts/update_account_repo.dart';



class UpdateAccountController extends GetxController {
  final UpdateAccountRepository updateaccountrepo;

  UpdateAccountController(this.updateaccountrepo);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  //CreateAccountModel? updateaccount;



  // Method to handle login
  Future<void> accountupdate(
      {

        required String accountName,
        required String exchangeId,

        required String apiKey,
        required String secretKey,

        required String accountId,
      }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response =   await updateaccountrepo.updateAccount(

          accountName: accountName,
          apiKey: apiKey,
          exchangeId: exchangeId,
          secretKey: secretKey,
          accountId: accountId
      );


      if (kDebugMode) {
        print('Update Account successful: ${response.account.accountName}');
        print('Update Account successful: ${response.account.id}');
      }

      Get.snackbar(
        'Successful',
        response.message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        backgroundColor: purple,
        colorText: white,
      );


    } catch (e) {
      ErrorHandler.handle(
        e,
        defaultErrorMessage: 'Failed to update account. Please try again.',
      );


      if (kDebugMode) {
        print('Update Account failed controller: $e');
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
