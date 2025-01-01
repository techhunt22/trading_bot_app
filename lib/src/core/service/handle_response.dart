import 'dart:convert';

import 'package:dio/dio.dart';

import '../error/exception.dart';

////////////////////////////////////
// General method for handling response
/////////////////////////////////////
Response handleResponse(Response response) {
  final statusCode = response.statusCode ?? 500;

  if (statusCode >= 200 && statusCode < 300) {
    return response;
  }

  final errorMessage = _getErrorMessage(response.data);
  final errorDetails = _getErrorDetails(response.data);

  throw ApiException(
    message: errorMessage,
    statusCode: statusCode,
    details: errorDetails,
  );
}

String _getErrorMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data['message'] ??
        data['error'] ??

        data['error_description'] ??
        'Unknown error';
  }
  return data?.toString() ?? 'Unknown error';
}

String _getErrorDetails(dynamic data) {
  if (data is Map<String, dynamic>) {
    // Try to get detailed error information
    final details = data['details'] ??
        data['error_details'] ??
        data['description'];

    if (details != null) {
      return details is String ? details : json.encode(details);
    }

    // If no specific details field exists, return the entire response
    return json.encode(data);
  }
  return data?.toString() ?? 'No details available';
}