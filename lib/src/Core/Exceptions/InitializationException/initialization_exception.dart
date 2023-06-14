import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:equatable/equatable.dart';

/// The `InitializationException` class represents an exception that occurs during Chapa initialization.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when there is an error during the initialization of Chapa.
/// The exception includes an optional error message (`msg`) as a string.
class InitializationException extends Equatable implements ChapaException {
  /// The error message associated with the exception.
  ///
  /// This variable stores the error message associated with the initialization exception.
  final String? msg;

  /// Constructs an `InitializationException` instance.
  ///
  /// The constructor takes an optional parameter, [msg], which represents the error message.
  const InitializationException({this.msg});

  @override
  List<Object?> get props => [msg];
}
