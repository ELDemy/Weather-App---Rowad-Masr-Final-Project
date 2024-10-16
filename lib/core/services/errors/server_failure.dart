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
    if (e.response != null) {
      int? statusCode = e.response?.statusCode;
      String message;

      // Check the status code and return the appropriate message
      switch (statusCode) {
        case 400:
          int? errorCode = e.response?.data['error']['code'];
          switch (errorCode) {
            case 1003:
              message = "city name not provided.";
              break;
            case 1005:
              message = "API request URL is invalid.";
              break;
            case 1006:
              message = e.response?.data['error']['message'];
              break;
            case 9000:
              message = "JSON body in bulk request is invalid.";
              break;
            case 9001:
              message = "Too many locations in bulk request. Limit to 50.";
              break;
            case 9999:
              message = "Internal application error.";
              break;
            default:
              message = "Bad request. Please try again!!";
          }
          break;

        case 401:
          int? errorCode = e.response?.data['error']['code'];
          switch (errorCode) {
            case 1002:
              message = "API key not provided.";
              break;
            case 2006:
              message = "API key provided is invalid.";
              break;
            default:
              message = "Unauthorized request.";
          }
          break;

        case 403:
          int? errorCode = e.response?.data['error']['code'];
          switch (errorCode) {
            case 2007:
              message = "API key has exceeded calls per month quota.";
              break;
            case 2008:
              message = "API key has been disabled.";
              break;
            case 2009:
              message =
                  "API key does not have access to this resource. Check your subscription plan.";
              break;
            default:
              message = "Forbidden request.";
          }
          break;

        case 404:
          message = "Resource not found. Check the endpoint or city name.";
          break;

        case 500:
          message = "Server error. Please try again later.";
          break;
        case 502:
          message = "Bad gateway. The server is down. Please try again later.";
          break;
        default:
          message = "An unexpected error occurred (Status code: $statusCode).";
      }

      return message;
    } else {
      // In case there's no response at all, return a generic error message
      return 'Unexpected error! Please try again later.';
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
