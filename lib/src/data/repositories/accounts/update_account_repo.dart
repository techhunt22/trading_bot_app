
import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';
import 'package:tradingapp_bot/src/data/models/accounts/create_account_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';

class UpdateAccountRepository {

  UpdateAccountRepository();
  final apiService = ApiService();

  Future<AccountModel> updateAccount({

    required String accountName,
    required String apiKey,
    required String exchangeId,
    required String secretKey,
    required String accountId,
  }) async {


    try {
      var endpoint =  ListAPI.updateaccount(accountId);
      var body = {

        'accountName': accountName,
        'exchangeId': exchangeId,
        'apiKey': apiKey,
        'secretKey': secretKey,

      };

      // Making the API call via ApiService
      final response = await apiService.put(endpoint, body: body);

      // Logging the response for debugging purposes

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Update Account API Response status: ${response.statusCode}');
        print('Update Account API data: ${response.data}');
        print('Message: ${response.data['message']}');
      }

      // Parsing the response into the PostLoginModel
      return AccountModel.fromJson(response.data);

    } catch (e) {
      if (kDebugMode) {
        print('Error in Create Account Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow; // Pass ApiException directly
      } else {
        throw ApiException(
          message: 'Failed to create account',
          statusCode: 500,
          details: e.toString(),
        );
      }
    }
  }
}