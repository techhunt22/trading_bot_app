import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';
import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';
import '../../models/coins/coin_trade_model.dart';

class BuyCoinsRepository {
  BuyCoinsRepository();

  final apiService = ApiService();

  Future<CoinTradeModel> buyCoins({
    required String accountId,
    required String symbol,
    required double quantity,
  }) async {
    try {
      var endpoint = ListAPI.buycoins;
      var body = {
        'accountId': accountId,
        'symbol': symbol,
        'quantity': quantity,
      };

      // Making the API call via ApiService
      final response = await apiService.post(endpoint, body: body);

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Buy Coins API Response status: ${response.statusCode}');
        print('Buy Coins Message: ${response.data['message']}');
        print('Buy Coins API data: ${response.data}');


      }

      // Parsing the response into the PostLoginModel

      return CoinTradeModel.fromJson(response.data);


    } catch (e) {
      if (kDebugMode) {
        print('Error in Buy Coins Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow; // Pass ApiException directly
      } else {
        throw ApiException(
          message: 'Failed to Buy Coins',
          statusCode: 500,
          details: e.toString(),
        );
      }
    }
  }
}