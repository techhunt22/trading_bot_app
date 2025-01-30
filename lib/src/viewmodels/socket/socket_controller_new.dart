import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../core/api_urls/api_urls.dart';


class SocketController extends GetxController {
  var botData = <String, dynamic>{}.obs; // Observable for botData
  var botUpdate = <String, dynamic>{}.obs; // Observable for botUpdate
  String? lastCoin;
  Timer? timer;
  var connectionStatus = 'Disconnected'.obs;
  final biggestDumpSymbolController = TextEditingController().obs;
  IO.Socket? socket;

  @override
  void onInit() {
    super.onInit();
    connect();
  }

  void clearData() {
    botData.clear();
    botUpdate.clear();
    lastCoin = null;
    biggestDumpSymbolController.value.clear();
    if (kDebugMode) {
      print("BOT DATA/UPDATE DATA CLEAR");
    }
  }

  void connect() {
    if (socket != null && socket!.connected) {
      return; // Already connected
    }
    socket = IO.io(
        ListAPI.baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableReconnection() // Enable reconnection
            .setReconnectionAttempts(20) // Limit the number of attempts
            .setReconnectionDelay(5000) // Wait 5 seconds before retrying
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

    socket?.on('botData', (data) {
      if (kDebugMode) {
        print('Received botData: $data');
      }
      try {
        var decodedData = data is String ? jsonDecode(data) : data;
        botUpdate.value = decodedData; // Update botUpdate observable
        

      } catch (e) {
        if (kDebugMode) {
          print('Error parsing botData: $e');
        }
      }
    });

    socket?.on('botUpdate', (data) {
      if (kDebugMode) {
        print('Received botUpdate: $data');
      }
      try {
        // Check if data is a JSON string or a simple string message
        var decodedData = data is String ? jsonDecode(data) : data;
        botUpdate.value = decodedData; // Update botUpdate observable

        // Check if decodedData contains 'lastcoin'
        if (decodedData is Map && decodedData.containsKey('messages')) {
          lastCoin = decodedData['messages'];
          if (kDebugMode) {
            print('Stored lastCoin: $lastCoin');
          }
          biggestDumpSymbolController.value.text = lastCoin!;
        }

      } catch (e) {
        if (kDebugMode) {
          print('Error parsing botUpdate: $e');
        }
      }
    });



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

  void disconnect() {
    if (socket != null && socket!.connected) {
      socket?.disconnect();
      connectionStatus.value = 'Disconnected';
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
}

// Error mapping dictionaries (same as before)
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


//   void onDataReceived(String jsonData) {
//   print('Received Data: $jsonData');
//   var decodedData = jsonDecode(jsonData);
//   data.value = decodedData;
//
//   // Store 'lastcoin' value if it exists
//   if (decodedData.containsKey('lastcoin')) {
//     lastCoin = decodedData['lastcoin'];
//     print('Stored lastCoin: $lastCoin');
//     biggestDumpSymbolController.value.text = lastCoin!;
//
//   }
// }

// String _generateMockData() {
//   List<String> mockDataList = [
//     jsonEncode({
//       "message": "Bot started successfully",
//       "coins": {
//         "USDT": "5.0",
//         "USDTC": "5.0",
//         "USDTB": "5.0"
//       },
//       "status": "Online"
//     }),
//     jsonEncode({
//       "message": "Bot started successfully",
//       "coins": [
//         "USDT",
//         "USDTC",
//         "USDTB"
//       ],
//       "alert": "Maintenance needed"
//     }),
//     jsonEncode({
//       "lastcoin": "COINUSD"
//     }),
//     jsonEncode({
//       "singleField":  "Single Object Value",
//       "otherField": "Other Value"
//     }),
//     jsonEncode({
//       "status": "Bot running",
//       "details": [
//         {"currency": "BTC", "value": "48000.0"},
//         {"currency": "ETH", "value": "3200.0"}
//       ]
//     }),
//     jsonEncode({
//       "alert": "High load detected",
//       "metrics": [
//         {"cpu": "85%", "memory": "75%"},
//         {"cpu": "90%", "memory": "80%"}
//       ]
//     }),
//     jsonEncode({
//       "lastcoin": "BTSCUSDT"
//     })
//   ];
//   int index = counter % mockDataList.length;
//   return mockDataList[index];
// }
