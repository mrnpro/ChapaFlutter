import 'package:equatable/equatable.dart';

/// The `AuthorizationEntity` class represents an entity for authorization in Chapa.
///
/// This class extends the `Equatable` class from the `equatable` package.
/// It is used to encapsulate the secret key required for authorization in Chapa.
class AuthorizationEntity extends Equatable {
  /// The secret key used for authorization.
  ///
  /// This variable stores the secret key required for authorization in Chapa.
  final String secretKey;

  /// Constructs an `AuthorizationEntity` instance.
  ///
  /// The constructor takes a required parameter, [secretKey], which represents the secret key for authorization.
  const AuthorizationEntity(this.secretKey);

  @override
  List<Object?> get props => [secretKey];
}
