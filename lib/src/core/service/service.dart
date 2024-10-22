import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api_urls/api_urls.dart';



class ApiService {
  final String baseUrl = ListAPI.baseUrl;
  final Dio dio = Dio();


// Step 1: Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Step 2: Private constructor
  ApiService._internal() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.connectTimeout = const Duration(seconds: 10); // 10 seconds timeout
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(InterceptorsWrapper(
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
    try {
      Response response = await dio.get(
        endpoint,
        options: Options(
          headers: headers,


        ),
        queryParameters: queryParams,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
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
    try {


      Response response = await dio.post(
        endpoint,
        options: Options(headers: headers,),
        data: body,

      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /////////////////////////////////////
  // General DELETE request method
  /////////////////////////////////////

  Future<Response> delete(
      String endpoint, {
        Map<String, dynamic>? headers,
      }) async {
    try {
      Response response = await dio.delete(
        endpoint,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
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
    try {
      Response response = await dio.put(
        endpoint,
        options: Options(headers: headers),
        data: body,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }


  ////////////////////////////////////
  // General method for handling response
  /////////////////////////////////////
  Response _handleResponse(Response response) {
    final int statusCode = response.statusCode ?? 500;
    final String responseBody = response.data != null
        ? jsonEncode(response.data)
        : 'No response data';

    if (statusCode >= 200 && statusCode < 300) {
      return response;
    } else if (statusCode >= 400 && statusCode < 500) {
      // Handle client-side errors
      switch (statusCode) {
        case 400:
          throw ApiException('Bad Request: $responseBody');
        case 401:
          throw ApiException('Unauthorized: $responseBody');
        case 403:
          throw ApiException('Forbidden: $responseBody');
        case 404:
          throw ApiException('Not Found: $responseBody');
        default:
          throw ApiException('Client Error ($statusCode): $responseBody');
      }
    } else if (statusCode >= 500 && statusCode < 600) {
      // Handle server-side errors
      switch (statusCode) {
        case 500:
          throw ApiException('Internal Server Error: $responseBody');
        case 502:
          throw ApiException('Bad Gateway: $responseBody');
        case 503:
          throw ApiException('Service Unavailable: $responseBody');
        default:
          throw ApiException('Server Error ($statusCode): $responseBody');
      }
    } else {
      // Handle unexpected status codes
      throw ApiException('Unexpected Error ($statusCode): $responseBody');
    }
  }


  ///////////////////////////////////
  // Error handling
  /////////////////////////////////


  ApiException _handleError(dynamic error) {
    String errorMessage = 'Unknown error occurred';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = error.response?.data != null
              ? 'Connection Timeout: ${error.response?.data['error']}'
              : 'Connection Timeout';
          if (kDebugMode) {
            print("SERVICE ERROR CONNECTION TIMEOUT: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = error.response?.data != null
              ? 'Send Timeout: ${error.response?.data['error']}'
              : 'Send Timeout';
          if (kDebugMode) {
            print("SERVICE ERROR SEND TIMEOUT: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");
          }
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = error.response?.data != null
              ? 'Receive Timeout: ${error.response?.data['error']}'
              : 'Receive Timeout';
          if (kDebugMode) {
            print("SERVICE ERROR RECEIVE TIMEOUT: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
        case DioExceptionType.badResponse:
          errorMessage = error.response?.data != null
              ? 'Bad Response: ${error.response?.data['error']}'
              : 'Received invalid status code: ${error.response?.statusCode}';
          if (kDebugMode) {
            print("SERVICE ERROR BAD RESPONSE: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
        case DioExceptionType.cancel:
          errorMessage = error.response?.data != null
              ? 'Request Cancelled: ${error.response?.data['error']}'
              : 'Request to API server was cancelled';
          if (kDebugMode) {
            print("SERVICE ERROR REQUEST CANCEL: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
        case DioExceptionType.unknown:
          errorMessage = error.response?.data != null
              ? 'Unknown Error : ${error.response?.data['error']}'
              : 'Unknown error occurred: ${error.message}';
          if (kDebugMode) {
            print("SERVICE ERROR UNKNOWN: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
        case DioExceptionType.badCertificate:
          errorMessage = error.response?.data != null
              ? 'Bad Certificate: ${error.response?.data['error']}'
              : 'Bad SSL certificate';
          if (kDebugMode) {
            print("SERVICE ERROR BAD CERTIFICATE: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
        case DioExceptionType.connectionError:
          errorMessage = error.response?.data != null
              ? 'Connection Error: ${error.response?.data['error']}'
              : 'Connection Error';
          if (kDebugMode) {
            print("SERVICE ERROR CONNECTION ERROR: ${error.response?.data['details']}");
            print("SERVICE ERROR STATUS CODE:${error.response?.statusCode}");

          }
          break;
      }
    } else {
      errorMessage = 'An unexpected error occurred: ${error.toString()}';
    }
    throw ApiException(errorMessage);
  }

  // ApiException _handleError(dynamic error) {
  //   String errorMessage = 'Unknown error occurred';
  //   if (error is DioException) {
  //     switch (error.type) {
  //       case DioExceptionType.connectionTimeout:
  //         errorMessage = 'Connection Timeout';
  //         break;
  //       case DioExceptionType.sendTimeout:
  //         errorMessage = 'Send Timeout';
  //         break;
  //       case DioExceptionType.receiveTimeout:
  //         errorMessage = 'Receive Timeout';
  //         break;
  //       case DioExceptionType.badResponse:
  //       // Extracting the error message from the response
  //         if (error.response != null && error.response?.data != null) {
  //           errorMessage = 'Error: ${error.response?.data['error'] }';
  //           print("SERVICE ERROR: ${error.response?.data['details']}");
  //         } else {
  //           errorMessage = 'Received invalid status code: ${error.response?.statusCode}';
  //         }
  //         break;
  //       case DioExceptionType.cancel:
  //         errorMessage = 'Request to API server was cancelled';
  //         break;
  //       case DioExceptionType.unknown:
  //         errorMessage = 'Unknown error occurred: ${error.message}';
  //         break;
  //       case DioExceptionType.badCertificate:
  //         errorMessage = 'Bad SSL certificate';
  //         break;
  //       case DioExceptionType.connectionError:
  //         errorMessage = 'Connection Error';
  //         break;
  //     }
  //   } else {
  //     errorMessage = 'An unexpected error occurred: ${error.toString()}';
  //   }
  //   throw ApiException(errorMessage);
  // }





  /////////////////////////////////////
  // Retry logic for API calls
  /////////////////////////////////////

  Future<T> retry<T>(Future<T> Function() function, {int maxRetries = 3}) async {
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        return await function();
      } catch (e) {
        if (attempt == maxRetries) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 2 * attempt));
      }
    }
    throw ApiException('Max retries exceeded');
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() {
    return message;
  }
}
