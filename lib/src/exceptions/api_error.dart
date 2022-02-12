/* When the API Server is not available */

class APIException implements Exception {
  String cause;

  APIException(this.cause);
}
