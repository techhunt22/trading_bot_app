import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';

import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';

class StartBotRepository {
  StartBotRepository();

  final apiService = ApiService();

  Future<Map<String, dynamic>> startBot({
    required String accountId,
  }) async {

    try {
      var endpoint = ListAPI.startbot;
      var body = {
        'accountId': accountId,
      };

      // Making the API call via ApiService
      final response = await apiService.post(endpoint, body: body);

      // Logging the response for debugging purposes

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Start Bot API Response status: ${response.statusCode}');
        print('Start Bot API data: ${response.data}');
      }

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print('Error in Start Bot Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow; // Pass ApiException directly
      } else {
        throw ApiException(
          message: 'Failed to Start Bot',
          statusCode: 500,
          details: e.toString(),
        );
      }
    }
  }
}
