import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:equatable/equatable.dart';

/// The `VerificationException` class represents an exception that occurs during the verification process.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when there is an error during the verification of a payment.
/// The exception includes an optional error message (`msg`) as a string.
class VerificationException extends Equatable implements ChapaException {
  /// The error message associated with the exception.
  ///
  /// This variable stores the error message associated with the verification exception.
  final String? msg;

  /// Constructs a `VerificationException` instance.
  ///
  /// The constructor takes an optional parameter, [msg], which represents the error message.
  const VerificationException({
    this.msg,
  });

  @override
  List<Object?> get props => [msg];
}
