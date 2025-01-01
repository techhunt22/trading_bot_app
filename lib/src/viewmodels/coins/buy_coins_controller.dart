import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/repositories/coins/buy_coins_repo.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';
import '../../data/models/coins/coin_trade_model.dart';

class BuyCoinsController extends GetxController {
  final BuyCoinsRepository buycoinsrepository;

  BuyCoinsController(this.buycoinsrepository);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  CoinTradeModel? buycoins;

  // Method to handle login
  Future<void> coinsBuys({
    required String accountId,
    required String symbol,
    required double quantity,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final CoinTradeModel result = await buycoinsrepository.buyCoins(
        accountId: accountId,
        symbol: symbol,
        quantity: quantity,
      );
      buycoins = result;
      update();
      if (kDebugMode) {
        print('Buy Coins successful: ${buycoins?.status}');
        print('Buy Coins message: ${buycoins?.message}');
        print('Order ID: ${buycoins?.data.order.orderId}');
        print('Symbol: ${buycoins?.data.order.symbol}');
        print('Quantity: ${buycoins?.data.order.quantity}');
        print('Price: ${buycoins?.data.order.price}');
        print('Status: ${buycoins?.data.order.status}');
        print('Type: ${buycoins?.data.order.type}');
        print('Side: ${buycoins?.data.order.side}');
        print('Timestamp: ${buycoins?.data.order.timestamp}');
      }

      Get.snackbar(
        '${buycoins?.status.toUpperCase()}',
        '${buycoins?.message}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        backgroundColor: purple,
        colorText: white,
      );
    } catch (error) {
      errorMessage.value = error.toString();

      if (kDebugMode) {
        print('Buy Coins failed controller: $error\n');
      }

      ErrorHandler.handle(
        error,
        defaultErrorMessage: 'Failed to Buy Coins. Please try again.',
        
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
