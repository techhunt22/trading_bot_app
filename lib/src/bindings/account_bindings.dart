import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/repositories/accounts/delete_account_repo.dart';
import 'package:tradingapp_bot/src/viewmodels/accounts/delete_account_controller.dart';

import '../data/repositories/accounts/all_accounts_repo.dart';
import '../data/repositories/accounts/update_account_repo.dart';
import '../viewmodels/accounts/all_accounts_controller.dart';
import '../viewmodels/accounts/update_account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllAccountController(AllAccountRepository()));
    Get.put(UpdateAccountController(UpdateAccountRepository()));
    Get.put(DeleteAccountController(DeleteAccountRepository()));
  }
}