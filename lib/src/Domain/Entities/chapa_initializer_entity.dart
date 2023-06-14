import 'package:equatable/equatable.dart';

/// The `ChapaIntializerEntity` class represents an entity for initializing a Chapa transaction.
///
/// This class extends the `Equatable` class from the `equatable` package.
/// It encapsulates the necessary parameters for initializing a Chapa transaction, such as amount, currency, and transaction reference.
class ChapaIntializerEntity extends Equatable {
  /// The amount of the transaction.
  final String amount;

  /// The currency of the transaction.
  final String currency;

  /// The email associated with the transaction.
  final String? email;

  /// The return URL for the transaction.
  final String? returnUrl;

  /// The first name of the user associated with the transaction.
  final String? firstName;

  /// The last name of the user associated with the transaction.
  final String? lastName;

  /// The phone number of the user associated with the transaction.
  final String? phoneNumber;

  /// The transaction reference.
  final String txRef;

  /// The callback URL for the transaction.
  final String? callbackUrl;

  /// The title of the transaction.
  final String? title;

  /// The description of the transaction.
  final String? description;

  /// Constructs a `ChapaIntializerEntity` instance.
  ///
  /// The constructor takes multiple parameters representing the various properties of the entity.
  const ChapaIntializerEntity({
    this.returnUrl,
    this.phoneNumber,
    required this.amount,
    required this.currency,
    this.email,
    this.firstName,
    this.lastName,
    required this.txRef,
    this.callbackUrl,
    this.title,
    this.description,
  });

  @override
  List<Object?> get props => [
        amount,
        currency,
        email,
        firstName,
        lastName,
        phoneNumber,
        txRef,
        callbackUrl,
        title,
        description,
      ];
}
