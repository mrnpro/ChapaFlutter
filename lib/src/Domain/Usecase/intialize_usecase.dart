import '../../Core/Exceptions/chapa_exception.dart';
import '../Entities/authorization_entity.dart';
import '../Entities/chapa_initializer_entity.dart';
import '../Repository/chapa_repo.dart';

/// The `IntializeUsecase` class handles the initialization of a Chapa transaction.
class IntializeUsecase {
  final ChapaRepository _chapaRepository;

  /// Constructs an `IntializeUsecase` object with the provided `ChapaRepository` instance.
  IntializeUsecase(this._chapaRepository);

  /// Initiates the Chapa transaction initialization process.
  ///
  /// It takes a `ChapaIntializerEntity` object named `chapaIntializer` and an `AuthorizationEntity` object named `authorizationEntity`
  /// as required parameters. The method returns a `Future` that resolves to a tuple `(String?, ChapaException?)`,
  /// indicating the result of the initialization process.
  Future<(String?, ChapaException?)> call({
    required ChapaIntializerEntity chapaIntializer,
    required AuthorizationEntity authorizationEntity,
  }) async {
    return await _chapaRepository.initialize(
        chapaIntializer, authorizationEntity);
  }
}
