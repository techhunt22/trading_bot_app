import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api_urls/api_urls.dart';
import '../error/exception.dart';
import 'handling.dart';



class ApiService {
  final String baseUrl = ListAPI.baseUrl;
  final Dio dio = Dio();


// Step 1: Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Step 2: Private constructor
  ApiService._internal() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers['Content-Type'] = 'application/json';

    dio.options.connectTimeout =
    const Duration(seconds: 10); // 10 seconds timeout
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(

        InterceptorsWrapper(

          onRequest: (options, handler) {
            if (kDebugMode) {
              print('Request: ${options.uri}');
            }
            return handler.next(options); // Continue
          },
          onResponse: (response, handler) {
            if (kDebugMode) {
              print('Response: ${response.data}');
            }
            return handler.next(response); // Continue
          },
          onError: (DioException e, handler) {
            if (kDebugMode) {
              print('Error: ${e.message}');
            }
            return handler.next(e); // Continue
          },
        ));
  }

  // Step 3: Factory constructor to return the singleton instance
  factory ApiService() {
    return _instance;
  }

  /////////////////////////////////////
  // General GET request method
  /////////////////////////////////////

  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParams,
      }) async {
    await _checkConnectionAndThrow(); // Using the new method

    try {
      Response response = await dio.get(
        endpoint,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParams,
      );
      return handleResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  /////////////////////////////////////
  // General POST request method
  /////////////////////////////////////

  Future<Response> post(
      String endpoint, {
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    await _checkConnectionAndThrow(); // Using the new method
    try {
      Response response = await dio.post(
        endpoint,
        options: Options(
          headers: headers,
        ),

        data: body,

      );

      return handleResponse(response);
    }
    catch (e) {
      throw handleError(e);
    }
  }

  /////////////////////////////////////
  // General DELETE request method
  /////////////////////////////////////

  Future<Response> delete(
      String endpoint, {
        Map<String, dynamic>? headers,
      }) async {
    await _checkConnectionAndThrow(); // Using the new method


    try {
      Response response = await dio.delete(
        endpoint,
        options: Options(headers: headers),
      );
      return handleResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  /////////////////////////////////////
// General PUT request method
/////////////////////////////////////

  Future<Response> put(
      String endpoint, {
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    await _checkConnectionAndThrow(); // Using the new method


    try {
      Response response = await dio.put(
        endpoint,
        options: Options(headers: headers),
        data: body,
      );
      return handleResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<void> _checkConnectionAndThrow() async {
    if (!await _checkConnection()) {
      throw ApiException(
        message:
            'No internet connection. Please check your network and try again.',
      );
    }
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<T> retry<T>(Future<T> Function() function,
      {int maxRetries = 3}) async {
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      //await _checkConnectionAndThrow(); // Using the new method


      try {
        return await function();
      } catch (e) {
        if (attempt == maxRetries) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 2 * attempt));
      }
    }
    throw ApiException(
      message: 'Max retries exceeded',
    );
  }
}
