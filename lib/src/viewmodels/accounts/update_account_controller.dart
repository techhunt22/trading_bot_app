import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Constants/color_constants.dart';
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
        required String type,
        required String accountName,
        required String exchangeId,
        required String apiKey,
        required String secretKey,
        required String passphrase,
        required String telegramUserId,
        required String accountId,
      }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
       await updateaccountrepo.updateAccount(
          type: type,
          accountName: accountName,
          exchangeId: exchangeId,
          apiKey: apiKey,
          secretKey: secretKey,
          passphrase: passphrase,
          telegramUserId: telegramUserId,
          accountId: accountId
      );


      // if (kDebugMode) {
      //   print('Update Account successful: ${updateaccount?.account.accountName}');
      // }
      // if (kDebugMode) {
      //   print('Update Account successful: ${updateaccount?.account.id}');
      // }
      Get.snackbar(
        'Successful',
        'Account has been Updated!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        backgroundColor: purple,
        colorText: white,
      );


    } catch (error) {
      errorMessage.value = error.toString();


      if (kDebugMode) {
        print('Update Account failed controller: $error');
      }
      Get.snackbar(
        'Update Account Failed',
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
