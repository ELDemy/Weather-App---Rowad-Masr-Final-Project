import 'dart:io'; // Import to use SocketException

import 'package:dio/dio.dart';

import 'failure_class.dart';

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
        return ServerFailure(_handleBadResponse(dioException));
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

  static String _handleBadResponse(DioException e) {
    if (e.response?.data != null) {
      return e.response?.data['error']['message'];
    } else {
      return 'Unexpected error!! Please Try again later...';
    }
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
