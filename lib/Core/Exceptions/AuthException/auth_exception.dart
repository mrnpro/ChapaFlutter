import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:equatable/equatable.dart';

/// The `AuthException` class represents an exception that occurs during authorization in Chapa.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when there is an authorization-related error in Chapa.
/// The exception includes an optional error message (`msg`) as a string.
class AuthException extends Equatable implements ChapaException {
  /// The error message associated with the exception.
  ///
  /// This variable stores the error message associated with the authorization exception.
  final String? msg;

  /// Constructs an `AuthException` instance.
  ///
  /// The constructor takes an optional parameter, [msg], which represents the error message.
  const AuthException({
    this.msg,
  });

  @override
  List<Object?> get props => [msg];
}
