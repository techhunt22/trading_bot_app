import 'package:dio/dio.dart';

import '../error/exception.dart';

ApiException handleError(dynamic error) {
  String errorMessage = 'Unknown error occurred';
  int? statusCode;
  String? details;
  String? message;

  if (error is DioException) {
    statusCode = error.response?.statusCode;

    // Check response structure and assign error details
    if (error.response?.data is Map<String, dynamic>) {
      details = error.response?.data['details']?.toString();
      message = error.response?.data['message']?.toString();
    } else {
      details = error.response?.data?.toString();
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection Timeout. Please try again';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive Timeout. Please try again';
        break;
      case DioExceptionType.badResponse:
        errorMessage =
        '$message\n${ details ?? 'Unknown server error occurred'}';
        break;
      default:
        errorMessage = error.message ?? 'Unknown error';
    }
  } else {
    errorMessage = 'Unexpected error: ${error.toString()}';
  }

  return ApiException(
    message: errorMessage,
    statusCode: statusCode,
    details: details,
  );
}