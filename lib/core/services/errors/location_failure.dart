import 'server_failure.dart';

class LocationFailure extends Failure {
  LocationFailure(super.errMsg);
  String get message => errMsg;
}

class CurrentLocationException implements Exception {
  String cause;
  CurrentLocationException(this.cause);
}
