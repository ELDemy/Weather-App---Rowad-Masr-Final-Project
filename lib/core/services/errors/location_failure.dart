import 'server_failure.dart';

class LocationFailure extends Failure {
  LocationFailure(super.errMsg);
}

class CurrentLocationException implements Exception {
  String cause;
  CurrentLocationException(this.cause);
}
