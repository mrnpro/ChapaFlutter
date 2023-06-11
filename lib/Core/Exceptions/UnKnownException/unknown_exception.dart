import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:equatable/equatable.dart';

/// The `UnknownChapaException` class represents an unknown or unexpected exception in the Chapa system.
///
/// This exception is a subtype of `ChapaException` and extends the `Equatable` class.
/// It can be thrown when an unknown or unexpected error occurs within the Chapa system.
class UnknownChapaException extends Equatable implements ChapaException {
  @override
  List<Object?> get props => [];
}
