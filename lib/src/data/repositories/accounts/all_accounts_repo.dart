import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';

import '../../../core/error/exception.dart';
import '../../../core/service/service.dart';
import '../../models/accounts/all_account_model.dart';

class AllAccountRepository {
  AllAccountRepository();

  final apiService = ApiService();

  Future<List<AllAccountModel>> getAllAccount() async {
    try {
      var endpoint = ListAPI.getallaccounts;

      // Making the API call via ApiService
      final response = await apiService.get(endpoint);

      // Logging the response for debugging purposes

      if (kDebugMode) {
        print('//////////////////////////////////////');
        print('Get All Account API Response status: ${response.statusCode}');
        print('Get All Account API data: ${response.data}');
      }

      String jsonString = json.encode(response.data);

      // List<dynamic> data = response.data;
      // return data.map((account) => AllAccountModel.fromJson(account)).toList();

      return allAccountModelFromJson(jsonString);


    } catch (e) {
      if (kDebugMode) {
        print('Error in Get All Accounts Repository: $e');
      }

      // Instead of handling error here, throw a custom exception
      if (e is ApiException) {
        rethrow;
      } else {
        throw ApiException(
          message: 'Failed to get all accounts',
          statusCode: 500,
          details: 'The server is temporarily unavailable.',
        );
      }
    }
  }
}
