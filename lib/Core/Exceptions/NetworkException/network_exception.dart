import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:equatable/equatable.dart';

/// The `NetworkException` class represents an exception that occurs due to network-related errors.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when there is a network-related error during a Chapa operation.
/// The exception includes an optional error message (`msg`) as a string.
class NetworkException extends Equatable implements ChapaException {
  /// The error message associated with the exception.
  ///
  /// This variable stores the error message associated with the network exception.
  final String? msg;

  /// Constructs a `NetworkException` instance.
  ///
  /// The constructor takes an optional parameter, [msg], which represents the error message.
  const NetworkException({this.msg});

  @override
  List<Object?> get props => [msg];
}
