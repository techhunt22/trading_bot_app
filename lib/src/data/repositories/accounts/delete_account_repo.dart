
import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';

import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';

class DeleteAccountRepository {

  DeleteAccountRepository();
  final apiService = ApiService();

  Future<Map<String, dynamic>> deleteAccountRepo({
    required String accountId,
  }) async {


    try {
      var endpoint =  ListAPI.deleteaccount(accountId);

      // Making the API call via ApiService
      final response = await apiService.delete(endpoint,);

      // Logging the response for debugging purposes

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Delete Account API Response status: ${response.statusCode}');
        print('Delete Account API data: ${response.data}');
      }

      return response.data;


    } catch (e) {
      if (kDebugMode) {
        print('Error in Delete Account Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow; // Pass ApiException directly
      } else {
        throw ApiException(
          message: 'Failed to delete account',
          statusCode: 500,
          details: e.toString(),
        );
      }
    }
  }
}