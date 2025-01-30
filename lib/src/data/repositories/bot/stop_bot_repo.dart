
import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';

import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';

class StopBotRepository {

  StopBotRepository();
  final apiService = ApiService();

  Future<Map<String, dynamic>> stopBot({
    required String accountId,
  }) async {


    try {
      var endpoint =  ListAPI.stopbot;
      var body = {
        'accountId': accountId,
      };

      // Making the API call via ApiService
      final response = await apiService.post(endpoint, body: body);
      // Making the API call via ApiService

      // Logging the response for debugging purposes

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Stop Bot API Response status: ${response.statusCode}');
        print('Stop Bot API data: ${response.data}');
      }

      return response.data;


    } catch (e) {
      if (kDebugMode) {
        print('Error in Stop Bot Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow; // Pass ApiException directly
      } else {
        throw ApiException(
          message: 'Failed to Stop Bot',
          statusCode: 500,
          details: e.toString(),
        );
      }
    }
  }
}