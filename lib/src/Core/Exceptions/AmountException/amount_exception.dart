import 'package:equatable/equatable.dart';

import '../../../../chapa_unofficial.dart';

/// The `AmountException` class represents an exception that occurs during maximum amount reached response from Chapa.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when there is an amount related error in Chapa.
/// The exception includes an optional error message (`msg`) as a string.
class AmountException extends Equatable implements ChapaException {
  /// The error message associated with the exception.
  ///
  /// This variable stores the error message associated with the amount exception.
  final String? msg;

  /// Constructs an `AmountException` instance.
  ///
  /// The constructor takes an optional parameter, [msg], which represents the error message.
  const AmountException({
    this.msg,
  });

  @override
  List<Object?> get props => [msg];
}
