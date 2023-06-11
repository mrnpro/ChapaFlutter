import 'package:chapa_unofficial/Domain/Repository/chapa_repo.dart';

import '../../Core/Exceptions/chapa_exception.dart';
import '../Entities/authorization_entity.dart';

/// The `VerifyUsecase` class handles the verification of a Chapa transaction.
class VerifyUsecase {
  final ChapaRepository _chapaRepository;

  /// Constructs a `VerifyUsecase` object with the provided `ChapaRepository` instance.
  VerifyUsecase(this._chapaRepository);

  /// Verifies a Chapa transaction.
  ///
  /// It takes a `String` parameter named `txRef` and an `AuthorizationEntity` object named `authorizationEntity`
  /// as required parameters. The method returns a `Future` that resolves to a tuple `(Map<String, dynamic>?, ChapaException?)`,
  /// representing the result of the verification process.
  Future<(Map<String, dynamic>?, ChapaException?)> call({
    required String txRef,
    required AuthorizationEntity authorizationEntity,
  }) async {
    return await _chapaRepository.verify(txRef, authorizationEntity);
  }
}
