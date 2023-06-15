/// The `Apis` class provides static URLs for Chapa API endpoints.
///
/// This class contains getter methods that return the API endpoint URLs for initializing and verifying transactions.
class Apis {
  Apis._();

  /// Returns the Chapa transaction initialization URL.
  ///
  /// This getter returns a string representing the URL for initializing Chapa transactions.
  static String get chapaIntializeUrl => "transaction/initialize";

  /// Returns the Chapa transaction verification URL.
  ///
  /// This getter returns a string representing the URL for verifying Chapa transactions.
  static String get chapaVerifyUrl => "transaction/verify/";
}
