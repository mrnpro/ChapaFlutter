import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:equatable/equatable.dart';

/// The `ServerException` class represents an exception that occurs on the server-side.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when there is an error on the server-side during a Chapa operation.
/// The exception includes an optional error message (`msg`) as a string.
class ServerException extends Equatable implements ChapaException {
  /// The error message associated with the exception.
  ///
  /// This variable stores the error message associated with the server exception.
  final String? msg;

  /// Constructs a `ServerException` instance.
  ///
  /// The constructor takes an optional parameter, [msg], which represents the error message.
  const ServerException({
    this.msg,
  });

  @override
  List<Object?> get props => [msg];
}
