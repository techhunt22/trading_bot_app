
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tradingapp_bot/src/core/api_urls/api_urls.dart';

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
      }
      if (kDebugMode) {
        print('Get All Account API Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Get All Account API data: ${response.data}');
      }
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // Convert the response body to a JSON string
        String jsonString = json.encode(response.data);


        // List<dynamic> data = response.data;
        // return data.map((account) => AllAccountModel.fromJson(account)).toList();

        return allAccountModelFromJson(jsonString);
      } else {
        throw Exception('Failed to load accounts');
      }


    } catch (e) {
      // Handle the exception and rethrow it to be handled by the controller
      if (kDebugMode) {
        print('Error in Get All Account Repository: $e');
      }
      rethrow;
    }
  }
}
