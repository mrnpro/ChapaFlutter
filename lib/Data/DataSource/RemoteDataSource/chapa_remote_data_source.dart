import '../../../Core/type_definitions.dart';

/// The abstract class for the Chapa remote data source.
abstract class ChapaRemoteDataSource {
  /// Makes a GET request to verify a transaction.
  ///
  /// - `txRef`: The transaction reference.
  /// - `privateKey`: The private key used for authorization.
  ///
  /// Returns a `Future` that resolves to a JSON object representing the response.
  Future<JsonType> getRequestVerify({
    required String txRef,
    required JsonType privateKey,
  });

  /// Makes a POST request to initialize a transaction.
  ///
  /// - `data`: The data object containing the transaction details.
  /// - `privateKey`: The private key used for authorization.
  ///
  /// Returns a `Future` that resolves to a JSON object representing the response.
  Future<JsonType> postRequestInitialize({
    required JsonType data,
    required JsonType privateKey,
  });
}
