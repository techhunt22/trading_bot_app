import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/models/accounts/create_account_model.dart';
import 'package:tradingapp_bot/src/data/repositories/accounts/create_account_repo.dart';
import '../../../Constants/color_constants.dart';



class CreateAccountController extends GetxController {
  final CreateAccountRepository createaccountrepo;

  CreateAccountController(this.createaccountrepo);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  CreateAccountModel? createAccount;



  // Method to handle login
  Future<void> accountcreate(
      {
        required String type,
        required String accountName,
        required String exchangeId,
        required String apiKey,
        required String secretKey,
        required String passphrase,
        required String telegramUserId,
      }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      createAccount = await createaccountrepo.createAccount(
          type: type,
          accountName: accountName,
          exchangeId: exchangeId,
          apiKey: apiKey,
          secretKey: secretKey,
          passphrase: passphrase,
          telegramUserId: telegramUserId
      );
      
      if (kDebugMode) {
        print('Create Account successful: ${createAccount?.account.accountName}');
      }

      if (kDebugMode) {
        print('Create Account successful: ${createAccount?.account.id}');
      }

      Get.snackbar(
        'Successful',
        '${createAccount?.account.accountName} account has been created!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        backgroundColor: purple,
        colorText: white,
      );


    } catch (error) {
      errorMessage.value = error.toString();


      if (kDebugMode) {
        print('Create Account failed controller: $error');
      }
      Get.snackbar(
        'Create Account Failed',
        '${errorMessage.value}!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(
            horizontal: 20 , vertical: 20),
        backgroundColor: red,
        colorText: white,
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
