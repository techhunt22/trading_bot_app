import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../data/models/accounts/all_account_model.dart';
import '../../data/repositories/accounts/all_accounts_repo.dart';



class AllAccountController extends GetxController {
  final AllAccountRepository allaccountrepo;

  AllAccountController(this.allaccountrepo);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var allAccounts = <AllAccountModel>[].obs; // List of accounts
  var selectedAccountId = RxnString();




  // TextEditingControllers as observables
  final accountName = TextEditingController().obs;
  final apiKey = TextEditingController().obs;
  final secretKey = TextEditingController().obs;
  final passphrase = TextEditingController().obs;
  final telegramId = TextEditingController().obs;
  final exchangeId = TextEditingController().obs;

  List<String> get accountIds => allAccounts.map((account) => account.id.toString()).toList();

  // @override
  // void onInit() {
  //   super.onInit();
  //   accountAll();
  // }

  @override
  void onClose() {
    accountName.value.dispose();
    apiKey.value.dispose();
    secretKey.value.dispose();
    passphrase.value.dispose();
    telegramId.value.dispose();
    exchangeId.value.dispose();
    super.onClose();
  }

  void fetchAccountDetails(String accountId) {
    final account = allAccounts.firstWhere(
            (account) => account.id == accountId,
        orElse: () => AllAccountModel(id: '', accountName: '', exchangeId: '', apiKey: '', secretKey: '', passphrase: '', telegramUserId: '')
    );

    selectedAccountId.value = accountId;
    accountName.value.text = account.accountName;
    apiKey.value.text = account.apiKey;
    secretKey.value.text = account.secretKey;
    passphrase.value.text = account.passphrase;
    telegramId.value.text = account.telegramUserId;
    exchangeId.value.text = account.exchangeId;
  }


  Future<void> accountAll() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      var accounts = await allaccountrepo.getAllAccount(); // Fetch the list of accounts
      allAccounts.assignAll(accounts); // Populate the observable list


      if (kDebugMode) {
        for (var account in accounts) {
          print('Account ID: ${account.id}');
          print('Account Name: ${account.accountName}');
        }
      }

      // Get.snackbar(
      //   'Successful',
      //   '${allaccount?.account.accountName} account has been Updated!',
      //   snackPosition: SnackPosition.BOTTOM,
      //   margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
      //   backgroundColor: purple,
      //   colorText: white,
      // );


    } catch (error) {
      errorMessage.value = error.toString();


      if (kDebugMode) {
        print('Get All Account failed controller: $error');
      }
      // Get.snackbar(
      //   'Update Account Failed',
      //   '${errorMessage.value}!',
      //   snackPosition: SnackPosition.BOTTOM,
      //   margin: const EdgeInsets.symmetric(
      //       horizontal: 20 , vertical: 20),
      //   backgroundColor: red,
      //   colorText: white,
      // );


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


