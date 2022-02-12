/* When the full Record Data is missing from the API */

class APIDataException implements Exception {
  String cause;

  APIDataException(this.cause);
}
