import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/error/error_handler.dart';
import '../../data/models/accounts/all_account_model.dart';
import '../../data/repositories/accounts/all_accounts_repo.dart';



class CoinsAccountController extends GetxController {
  final AllAccountRepository allaccountrepo;
  CoinsAccountController(this.allaccountrepo);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var allAccounts = <AllAccountModel>[].obs;
  var selectedAccountname = ''.obs;
  final idcontroller = TextEditingController().obs;


  void resetFields() {
    // Clear the text fields using their controllers
    idcontroller.value.clear();
  }

  @override
  void onClose() {
    idcontroller.value.dispose();



    super.onClose();
  }

  List<Map<String, dynamic>> get accountItems {
    return allAccounts
        .map((account) => {
      'value': account.accountName, // The value to be used in the dropdown
      'label': account.accountName, // The label to be displayed

    })
        .toList();
  }
  void setSelectedAccount(String accname) {
    final account = allAccounts.firstWhere(
          (account) => account.accountName == accname,
      orElse: () => AllAccountModel(id: '', exchangeId: 'Binance',accountName: '', apiKey: '', secretKey: '', ), // Default value if not found
    );
    selectedAccountname.value = accname;
    idcontroller.value.text = account.id;
  }





  // Fetch accounts
  Future<void> fetchAccounts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      var accounts = await allaccountrepo.getAllAccount(); // Fetch the list of accounts
      allAccounts.assignAll(accounts); // Populate the observable list




      if (kDebugMode) {
        for (var account in accounts) {
          print('Account ID: ${account.id} : ${account.accountName}');
        }
      }
    } catch (error) {
      errorMessage.value = error.toString();
      if (kDebugMode) {
        print('Get All Account for Coins failed controller: $error');
      }

      ErrorHandler.handle(
        errorMessage.value,
        defaultErrorMessage: 'Failed to get all accounts for Coins. Please try again.',
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


