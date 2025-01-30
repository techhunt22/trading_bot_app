import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/error/error_handler.dart';
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
  final accname = TextEditingController().obs;
  final apiKey = TextEditingController().obs;
  final secretKey = TextEditingController().obs;
  final exchangeId = TextEditingController().obs;

  void resetFields() {
    // Clear the text fields using their controllers
    accname.value.clear();
    apiKey.value.clear();
    secretKey.value.clear();
    exchangeId.value.clear();
  }
  List<String> get accountIds => allAccounts.map((account) => account.id.toString()).toList();

  // @override
  // void onInit() {
  //   super.onInit();
  //   accountAll();
  // }

  @override
  void onClose() {
    accname.value.dispose();
    apiKey.value.dispose();
    secretKey.value.dispose();
    exchangeId.value.dispose();


    super.onClose();
  }

  void fetchAccountDetails(String accountId) {
    final account = allAccounts.firstWhere(
            (account) => account.id == accountId,
        orElse: () => AllAccountModel(
            id: '', accountName: '', exchangeId: '', apiKey: '', secretKey: '', )
    );

    selectedAccountId.value = accountId;
    accname.value.text = account.accountName;
    exchangeId.value.text = account.exchangeId;
    apiKey.value.text = account.apiKey;
    secretKey.value.text = account.secretKey;

  }


  Future<void> accountAll() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      var accounts = await allaccountrepo.getAllAccount(); // Fetch the list of accounts
      allAccounts.assignAll(accounts); // Populate the observable list


      if (kDebugMode) {
        for (var account in accounts) {
          print('Account ID: ${account.id} : ${account.accountName} ${account.exchangeId}');
        }
      }


    } catch (error) {
      errorMessage.value = error.toString();


      if (kDebugMode) {
        print('Get All Account failed controller: $error');
      }
      ErrorHandler.handle(
        error,
        defaultErrorMessage: 'Failed to get all accounts. Please try again.',

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


