/// The `HttpConfig` class provides the base URL for Chapa API requests.
///
/// This class contains a getter method that returns the base URL for making HTTP requests to the Chapa API.
class HttpConfig {
  HttpConfig._();

  /// Returns the base URL for Chapa API requests.
  ///
  /// This getter returns a string representing the base URL for making HTTP requests to the Chapa API.
  static String get chapaBaseUrl => 'https://api.chapa.co/v1/';
}
