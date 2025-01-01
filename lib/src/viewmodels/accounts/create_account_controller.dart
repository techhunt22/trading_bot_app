import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/models/accounts/create_account_model.dart';
import 'package:tradingapp_bot/src/data/repositories/accounts/create_account_repo.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';



class CreateAccountController extends GetxController {
  final CreateAccountRepository createaccountrepo;

  CreateAccountController(this.createaccountrepo);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  AccountModel? createAccount;



  // Method to handle login
  Future<void> accountcreate(
      {
        required String accountName,

        required String apiKey,
        required String secretKey,
      }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
     final createAccount = await createaccountrepo.createAccount(
          accountName: accountName,
          apiKey: apiKey,
          secretKey: secretKey,

      );
      
      if (kDebugMode) {
        print('Create Account successful: ${createAccount.account.accountName}');
        print('Create Account successful: ${createAccount.account.id}');

      }


      Get.snackbar(
        'Successful',
        '${createAccount.account.accountName} ${createAccount.message}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        backgroundColor: purple,
        colorText: white,
      );


    } catch (error) {

      errorMessage.value = error.toString();


      if (kDebugMode) {
        print('Create Account failed controller: $error\n');
      }

      ErrorHandler.handle(
        error,
        defaultErrorMessage: 'Failed to create account. Please try again.',
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
