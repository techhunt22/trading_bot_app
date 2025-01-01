import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tradingapp_bot/src/data/repositories/coins/sell_coins_repo.dart';
import '../../../Constants/color_constants.dart';
import '../../core/error/error_handler.dart';
import '../../data/models/coins/coin_trade_model.dart';



class SellCoinsController extends GetxController {
  final SellCoinsRepository sellcoinsrepository;

  SellCoinsController(this.sellcoinsrepository);

  // Observables for managing UI state
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  CoinTradeModel? sellcoins;



  // Method to handle login
  Future<void> coinsSell(
      {
        required String accountId,
        required String symbol,
        required double quantity,
      }

      ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final CoinTradeModel result  = await sellcoinsrepository.sellCoins(
        accountId: accountId,
        symbol: symbol,
        quantity: quantity,

      );
      sellcoins = result;

      if (kDebugMode) {
        print('Sell Coins successful: ${sellcoins?.status}');
        print('Sell Coins message: ${sellcoins?.message}');
        print('Order ID: ${sellcoins?.data.order.orderId}');
        print('Symbol: ${sellcoins?.data.order.symbol}');
        print('Quantity: ${sellcoins?.data.order.quantity}');
        print('Price: ${sellcoins?.data.order.price}');
        print('Status: ${sellcoins?.data.order.status}');
        print('Type: ${sellcoins?.data.order.type}');
        print('Side: ${sellcoins?.data.order.side}');
        print('Timestamp: ${sellcoins?.data.order.timestamp}');
      }


      Get.snackbar(
        '${sellcoins?.status.toUpperCase()}',
        '${sellcoins?.message}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        backgroundColor: purple,
        colorText: white,
      );


    } catch (error) {

      errorMessage.value = error.toString();


      if (kDebugMode) {
        print('Sell Coins failed controller: $error\n');
      }

      ErrorHandler.handle(
        error,
        defaultErrorMessage: 'Failed to Sell Coins. Please try again.',
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
