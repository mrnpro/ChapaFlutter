import '../../Core/type_definitions.dart';
import '../../Domain/Entities/authorization_entity.dart';

/// The model class representing the authorization entity.
class AuthorizationModel extends AuthorizationEntity {
  /// Creates an instance of [AuthorizationModel] with the given `publicKey`.
  const AuthorizationModel(String publicKey) : super(publicKey);

  /// Factory method to create an [AuthorizationModel] from an [AuthorizationEntity].
  ///
  /// - `entity`: The [AuthorizationEntity] to create the [AuthorizationModel] from.
  ///
  /// Returns an instance of [AuthorizationModel].
  factory AuthorizationModel.fromEntity(AuthorizationEntity entity) {
    return AuthorizationModel(entity.secretKey);
  }

  /// Converts the [AuthorizationModel] to a JSON object.
  ///
  /// Returns a [JsonType] object representing the JSON conversion of the [AuthorizationModel].
  JsonType toJson() {
    return {
      "Authorization": "Bearer ${super.secretKey}",
    };
  }
}
