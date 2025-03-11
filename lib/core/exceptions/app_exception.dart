class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException() : super("No internet connection.");
}

class ServerException extends AppException {
  ServerException() : super("Server error occurred. Please try again.");
}

class CacheException extends AppException {
  CacheException() : super("Failed to load cached data.");
}
