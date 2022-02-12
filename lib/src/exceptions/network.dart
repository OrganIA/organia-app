/* When the Network is not available */

class NetworkException implements Exception {
  String cause;

  NetworkException(this.cause);
}
