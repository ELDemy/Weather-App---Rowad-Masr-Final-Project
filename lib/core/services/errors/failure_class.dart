import 'dart:io'; // Import to use SocketException

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMsg;
  const Failure(this.errMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  // Factory constructor to handle different Dio exceptions and response codes
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad SSL certificate!');
      case DioExceptionType.badResponse:
        return ServerFailure(
            _handleBadResponse(dioException.response?.statusCode));
      case DioExceptionType.cancel:
        return ServerFailure('Request to server was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(_handleConnectionError(dioException));
      case DioExceptionType.unknown:
        return ServerFailure('An unknown error occurred. Please try again.');
      default:
        return ServerFailure('Something went wrong!');
    }
  }

  // Simplified map for handling common HTTP status codes
  static String _handleBadResponse(int? statusCode) {
    const statusCodeMessages = {
      400: 'Bad request. Please check your input.',
      401: 'Unauthorized. Please log in again.',
      403: 'Forbidden. You don’t have permission to access this resource.',
      404: 'Not found. The resource you’re looking for doesn’t exist.',
      500: 'Internal server error. Please try again later.',
      503: 'Service unavailable. Please try again later.',
    };

    return statusCodeMessages[statusCode] ??
        'Received unexpected status code: $statusCode';
  }

  // Check if Dio error wraps a SocketException
  static String _handleConnectionError(DioException dioException) {
    if (dioException.error is SocketException) {
      return 'No Internet connection. Please check your network.';
    } else {
      return 'Failed to connect to the server. Please check your internet connection.';
    }
  }
}
