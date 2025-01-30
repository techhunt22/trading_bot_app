
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../error/exception.dart';

///////////////////////////////////
// Handle Errors
///////////////////////////////////
final Logger _logger = Logger();

Exception handleError(dynamic error) {
  _logger.e('Error occurred: $error');

  if (error is DioException) {
    // Check if we have a response (i.e., it's a bad response)
    if (error.response != null) {
      return _handleErrorResponse(error.response!);
    }

    // Handle DioException (network or server related issues)
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        _logger.e('Connection timeout occurred.');
        return ApiException(message: 'Connection timeout occurred.');

      case DioExceptionType.receiveTimeout:
        _logger.e('Receive timeout occurred.');
        return ApiException(message: 'Receive timeout occurred.');

      case DioExceptionType.sendTimeout:
        _logger.e('Send timeout occurred.');
        return ApiException(message: 'Send timeout occurred.');

      case DioExceptionType.cancel:
        _logger.e('Request was cancelled.');
        return ApiException(message: 'Request was cancelled.');

      case DioExceptionType.unknown:
        _logger.e('Unknown error: ${error.message}');
        return ApiException(message: 'Unknown error: ${error.message}');

      default:
        _logger.e('Unknown Dio error: ${error.message}');
        return ApiException(message: 'Unknown Dio error: ${error.message}');
    }
  } else if (error is SocketException) {
    // Handle no internet or network issues
    _logger.e('No internet connection: $error');
    return ApiException(message: 'No internet connection. Please check your network.');
  } else {
    // Handle any other types of errors
    _logger.e('Unexpected error occurred: $error');
    return ApiException(message: 'Unexpected error occurred: ${error.toString()}');
  }
}

/// Handles bad responses (e.g., 401, 404, 500) and creates proper exception messages.
ApiException _handleErrorResponse(Response response) {
  String errorMessage = _extractErrorMessage(response);

  // Log the error for debugging purposes
  _logger.e('Error Response received: ${response.statusCode} - ${response.data}');

  switch (response.statusCode) {
    case 400:
      return ApiException(message: 'Bad Request: $errorMessage');
    case 401:
      return ApiException(message: 'Unauthorized: $errorMessage');
    case 403:
      return ApiException(message: 'Forbidden: $errorMessage');
    case 404:
      return ApiException(message: 'Not Found: $errorMessage');
    case 409:
      return ApiException(message: 'Conflict: $errorMessage');
    case 429:
      return ApiException(message: 'Too Many Requests: $errorMessage');
    case 500:
      return ApiException(message: 'Internal Server Error: $errorMessage');
    case 502:
      return ApiException(message: 'Bad Gateway: $errorMessage');
    case 503:
      return ApiException(message: 'Service Unavailable: $errorMessage');
    case 504:
      return ApiException(message: 'Gateway Timeout: $errorMessage');
    default:
      return ApiException(message: 'Unexpected Error: $errorMessage');
  }
}

/// Helper function to extract error message from response
String _extractErrorMessage(Response response) {
  try {
    if (kDebugMode) {
      print('Raw error response: ${response.data}');
    }

    if (response.data is Map<String, dynamic>) {
      final message = response.data['message'] ?? 'An error occurred, Please try again';
      if (kDebugMode) {
        print('Error response: $message');
      }
      return message;
    }


    // Fallback for unexpected response types
    return response.data?.toString() ?? 'An unknown error occurred.';
  } catch (e) {
    _logger.e('Error extracting message from response: $e');
    return 'Failed to parse error message.';
  }
}


///////////////////////////////////
// Handle Response
///////////////////////////////////
Response handleResponse(Response response) {
  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
    // Log and return the successful response
    _logger.i('Response received: ${response.statusCode} - ${response.data}');
    return response;
  }

  // If status code is not in the successful range, throw error (this is handled by Dio)
  // so we don't need to manually handle it here.
  throw ApiException(message: 'Unexpected Error: ${response.statusCode}');
}
