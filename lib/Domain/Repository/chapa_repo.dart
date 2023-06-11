import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:chapa_unofficial/Domain/Entities/chapa_initializer_entity.dart';

import '../Entities/authorization_entity.dart';

/// The `ChapaRepository` abstract class defines the contract for interacting with the Chapa API.
///
/// This class provides methods for initializing a Chapa transaction and verifying a payment.
/// It takes in the necessary entities for authorization and transaction initialization.
abstract class ChapaRepository {
  /// Initializes a Chapa transaction.
  ///
  /// This method takes a [chapaIntializer] of type `ChapaIntializerEntity` representing the details of the transaction initialization,
  /// and an [authorizationEntity] of type `AuthorizationEntity` for authorization.
  /// It returns a `Future` that resolves to a Dart Record of a `String` representing the checkout URL and a `ChapaException` in case of errors.
  Future<(String?, ChapaException?)> initialize(
      ChapaIntializerEntity chapaIntializer,
      AuthorizationEntity authorizationEntity);

  /// Verifies a Chapa payment.
  ///
  /// This method takes a [txRef] of type `String` representing the transaction reference,
  /// and an [authorizationEntity] of type `AuthorizationEntity` for authorization.
  /// It returns a `Future` resolves to a Dart Record of a `Map<String, dynamic>` representing the payment data and a `ChapaException` in case of errors.
  Future<(Map<String, dynamic>?, ChapaException?)> verify(
      String txRef, AuthorizationEntity authorizationEntity);
}
