import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../data/models/coins/all_coins_model.dart';

class SocketController extends GetxController {
  IO.Socket? socket;

  // Observable variables to store event data
  var botData = <String>[].obs; // List<String> to store the coin data
  var botUpdate = <String>[].obs; // List<String> to store the bot update data
  var clientError = ''.obs;
  var tradeExecuted = ''.obs;
  var connectionStatus = 'Disconnected'.obs;
  var biggestDumpSymbol = ''.obs; // New variable to store the message
  final biggestDumpSymbolController = TextEditingController( ).obs;
  var userEdited = false.obs;

  // Automatically connect when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    connect();
    if (kDebugMode) {
      print("SOCKET AUTOMATICALLY CONENCTED");
    }
    ever(biggestDumpSymbol, (value) {
      if (!userEdited.value) {
        if (value.isNotEmpty) {
          biggestDumpSymbolController.value.text = value;
          biggestDumpSymbolController.value.selection = TextSelection.collapsed(offset: biggestDumpSymbolController.value.text.length);

          if (kDebugMode) {
            print(biggestDumpSymbolController.value.text);
          }
        } else {
          biggestDumpSymbolController.value.text = "No Data"; // Fallback if no data
          if (kDebugMode) {
            print(biggestDumpSymbolController.value.text);
          }

        }
      }
    });

  }


  @override
  void onClose() {
    biggestDumpSymbolController.value.dispose();
    super.onClose();
  }


  // Method to connect to the socket server
  void connect() {
    if (socket != null && socket!.connected) {
      return; // Already connected


    }

    socket = IO.io(
        'https://opo.techhunt.info',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableReconnection()  // Enable reconnection
            .setReconnectionAttempts(20)   // Limit the number of attempts
            .setReconnectionDelay(5000)   // Wait 5 seconds before retrying
            .setReconnectionDelayMax(10000) // Maximum wait of 10 seconds
            .setTimeout(5000)
            .build());



    // Connect to the server
    socket?.onConnect((_) {
      connectionStatus.value = 'Connected to server';
      socket?.emit('message', 'Hello, server!');
      if (kDebugMode) {
        print('Connected to server');
      }
    });

    // Listen for messages from the server
    socket?.on('botData', (data) {
      if (kDebugMode) {
        print('Received botData: $data');
      } // Log the received raw data
      try {
        if (data != null && data is Map<String, dynamic>) {
          if (data.containsKey('coins')) {
            AllCoinsDataModel coinsData = AllCoinsDataModel.fromJson(data);
            botData.value = coinsData.coins; // Update botData observable with list of coins
            if (botData.isEmpty) {
              if (kDebugMode) {
                print('No Coins: ${data['message']}');
              }

            } else {
              if (kDebugMode) {
                print('BOT DATA: ${coinsData.coins}');
                print('BOT DATA: ${coinsData.coins.length}');

              }
            }
          } else {
            if (kDebugMode) {
              print('Received botData message: ${data['message']}');
            }

          }
        } else {
          if (kDebugMode) {
            print('Received invalid or null data for botData');

          }
          if (kDebugMode) {
            print('Received invalid data: ${data['message']}');
          }

        }
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing botData: $e');

        }
      }
    });





    socket?.on('botUpdate', (data) {
      if (kDebugMode) {
        print('Received botUpdate: $data');
      } // Log the received raw data

      try {
        if (data != null) {
          if (data != null && data is Map<String, dynamic> && data.containsKey('lastcoin')) {
            botUpdate.value = [];  // Clear the botUpdate (listed coins) list

            biggestDumpSymbol.value = data['lastcoin'];
            biggestDumpSymbolController.value.text = data['lastcoin']; // Update controller text

            if (kDebugMode) {
              print('Biggest Dump Symbol: ${biggestDumpSymbol.value}');
              print('Biggest Dump Symbol: ${biggestDumpSymbolController.value.text}');
            }
          }
          else{
            biggestDumpSymbol.value = '';
            biggestDumpSymbolController.value.text = '';

            // Parse the botUpdate data
            AllCoinsUpdateModel updateData = AllCoinsUpdateModel.fromJson(data);
            botUpdate.value = updateData.listedCoins; // Update botUpdate observable with list of updated coins
            if (botUpdate.isEmpty) {
              if (kDebugMode) {
                print('Info No updates available');
              }

            } else {
              if (kDebugMode) {
                print('BOT UPDATE: ${updateData.listedCoins}');
                print('BOT UPDATE DATA: ${updateData.listedCoins.length}');

              }
            }
          }
        } else {
          if (kDebugMode) {
            print('Received null data for botUpdate');
          }

        }
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing botUpdate: $e');
        }

      }
    });

    socket?.on('clientError', (data) {
      clientError.value = data.toString();
      if (kDebugMode) {
        print('Client Error: $data');
      }
    });

    socket?.on('tradeExecuted', (data) {
      tradeExecuted.value = data.toString();
      if (kDebugMode) {
        print('Trade Executed: $data');
      }
    });

    // Handle disconnection
    socket?.onDisconnect((_) {
      connectionStatus.value = 'Disconnected from server';
      if (kDebugMode) {
        print('Disconnected from server');
      }
    });

    // Error handling
    socket?.onConnectError((err) {
      String userFriendlyMessage = _getUserFriendlyMessage(err, context: 'Connection');
      connectionStatus.value = userFriendlyMessage;
      if (kDebugMode) {
        print('Connection error');
      }
    });

    socket?.onError((err) {
      String userFriendlyMessage = _getUserFriendlyMessage(err, context: 'Connection');
      connectionStatus.value = userFriendlyMessage;
      if (kDebugMode) {
        print('Socket error');
      }

    });



  }


  // Method to disconnect from the socket server
  void disconnect() {
    if (socket != null && socket!.connected) {
      socket?.disconnect();
      connectionStatus.value = 'Disconnected';

      botData.clear(); // Clear the data on disconnect
      botUpdate.clear(); // Clear the bot update data
      clientError.value = '';
      tradeExecuted.value = '';
    }
  }


}

String _getUserFriendlyMessage(dynamic error, {required String context}) {
  // Define mappings of technical errors to user-friendly messages

  final allErrorMappings = {
    ...networkErrorMapping,
    ...socketErrorMapping,
    ...serverErrorMapping,
    ...sslErrorMapping,
  };


  if (error is String) {
    return allErrorMappings[error] ?? 'An unexpected $context error occurred. Please try again.';
  } else if (error is int) {
    // Handle HTTP status codes
    return serverErrorMapping[error] ?? 'Unexpected server response: $error';
  } else if (error is Map && error.containsKey('message')) {
    // Handle error objects with a 'message' property
    return allErrorMappings[error['message']] ?? error['message'];
  }

  return 'An unexpected $context error occurred. Please try again later.';
}




const networkErrorMapping = {
  'ECONNREFUSED': 'The server is currently unavailable. Please try again later.',
  'ETIMEDOUT': 'The connection timed out. Please check your internet and try again.',
  'EHOSTUNREACH': 'Unable to reach the server. Please check your network settings.',
  'ENETDOWN': 'The network is currently down. Please reconnect and try again.',
  'ENOTFOUND': 'Server not found. Please check the server address.',
  'ECONNRESET': 'Connection reset by the server. Trying again might resolve the issue.',
  'EPIPE': 'Broken connection. Please retry.',
};
const socketErrorMapping = {
  'EADDRINUSE': 'The address is already in use. Try closing conflicting applications.',
  'EADDRNOTAVAIL': 'The requested address is not available. Check your settings.',
  'ENOTSOCK': 'Invalid socket operation. Contact support for assistance.',
  'EMFILE': 'Too many open files. Please close some connections and try again.',
  'EBADF': 'Invalid file descriptor. Restarting the app may resolve the issue.',
};
const serverErrorMapping = {
  400: 'Invalid request. Please check the information you provided.',
  401: 'Unauthorized access. Please log in and try again.',
  403: 'Access denied. You don’t have the necessary permissions.',
  404: 'The requested resource was not found.',
  408: 'Request timeout. Please try again later.',
  429: 'Too many requests. Please wait before trying again.',
  500: 'Internal server error. The team is working to fix it.',
  502: 'Bad gateway. The server received an invalid response.',
  503: 'Service unavailable. Please try again later.',
  504: 'Gateway timeout. The server is taking too long to respond.',
};
const sslErrorMapping = {
  'UNABLE_TO_VERIFY_LEAF_SIGNATURE': 'The server’s SSL certificate could not be verified.',
  'CERT_HAS_EXPIRED': 'The server’s SSL certificate has expired.',
  'DEPTH_ZERO_SELF_SIGNED_CERT': 'The server is using an untrusted certificate.',
  'ERR_TLS_CERT_ALTNAME_INVALID': 'The server’s SSL certificate does not match the expected domain.',
};
const databaseErrorMapping = {
  'ER_ACCESS_DENIED_ERROR': 'Access denied. Please check your database credentials.',
  'ER_BAD_DB_ERROR': 'Database not found. Please verify the database name.',
  'ER_LOCK_WAIT_TIMEOUT': 'Database lock timeout. Please try again.',
  'ER_DUP_ENTRY': 'Duplicate entry. The data you’re trying to add already exists.',
};