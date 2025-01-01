import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';
import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';
import '../../models/coins/coin_trade_model.dart';

class SellCoinsRepository {
  SellCoinsRepository();

  final apiService = ApiService();

  Future<CoinTradeModel> sellCoins({
    required String accountId,
    required String symbol,
    required double quantity,
  }) async {
    try {
      var endpoint = ListAPI.sellcoins;
      var body = {
        'accountId': accountId,
        'symbol': symbol,
        'quantity': quantity,
      };

      // Making the API call via ApiService
      final response = await apiService.post(endpoint, body: body);

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Sell Coins Message: ${response.data['message']}');
        print('Sell Coins API Response status: ${response.statusCode}');
        print('Sell Coins API data: ${response.data}');

      }

      // Parsing the response into the PostLoginModel

      return CoinTradeModel.fromJson(response.data);


    } catch (e) {
      if (kDebugMode) {
        print('Error in Sell Coins Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow; // Pass ApiException directly
      } else {
        throw ApiException(
          message: 'Failed to Sell Coins',
          statusCode: 500,
          details: e.toString(),
        );
      }
    }
  }
}