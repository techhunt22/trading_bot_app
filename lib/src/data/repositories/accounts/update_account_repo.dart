
import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';
import 'package:tradingapp_bot/src/data/models/accounts/create_account_model.dart';

import '../../../core/service/service.dart';

class UpdateAccountRepository {

  UpdateAccountRepository();
  final apiService = ApiService();

  Future<CreateAccountModel> updateAccount({
    required String type,
    required String accountName,
    required String exchangeId,
    required String apiKey,
    required String secretKey,
    required String passphrase,
    required String telegramUserId,
    required String accountId,
  }) async {


    try {
      var endpoint =  ListAPI.updateaccount(accountId);
      var body = {
        'type': type,
        'accountName': accountName,
        'exchangeId': exchangeId,
        'apiKey': apiKey,
        'secretKey': secretKey,
        'passphrase': passphrase,
        'telegramUserId': telegramUserId,
      };

      // Making the API call via ApiService
      final response = await apiService.post(endpoint, body: body);

      // Logging the response for debugging purposes

      if (kDebugMode) {
        print('//////////////////////////////////////');
      }
      if (kDebugMode) {
        print('Update Account API Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Update Account API data: ${response.data}');
      }

      // Parsing the response into the PostLoginModel
      return CreateAccountModel.fromJson(response.data);

    } catch (e) {
      // Handle the exception and rethrow it to be handled by the controller
      if (kDebugMode) {
        print('Error in Update Account Repository: $e');
      }
      rethrow;
    }
  }
}
