import 'package:chapa_unofficial/Core/Exceptions/chapa_exception.dart';
import 'package:chapa_unofficial/Data/DataSource/RemoteDataSource/chapa_remote_data_source.dart';
import 'package:chapa_unofficial/Data/Model/authorization_model.dart';
import 'package:chapa_unofficial/Data/Model/chapa_initializer_model.dart';
import 'package:chapa_unofficial/Domain/Entities/authorization_entity.dart';
import 'package:chapa_unofficial/Domain/Entities/chapa_initializer_entity.dart';
import 'package:chapa_unofficial/Domain/Repository/chapa_repo.dart';

import '../../Core/type_definitions.dart';

/// The implementation of the [ChapaRepository] interface.
class ChapaRepoImpl implements ChapaRepository {
  final ChapaRemoteDataSource _remoteDataSource;

  /// Creates an instance of [ChapaRepoImpl] with the given [ChapaRemoteDataSource].
  ///
  /// - `_remoteDataSource`: The remote data source to be used.
  ChapaRepoImpl(this._remoteDataSource);

  @override
  Future<(String?, ChapaException?)> initialize(
      ChapaIntializerEntity chapaIntializer,
      AuthorizationEntity authorizationEntity) async {
    try {
      // Call the postRequestInitialize method of the remote data source to initialize the Chapa payment.
      JsonType response = await _remoteDataSource.postRequestInitialize(
        data: ChapaIntializerModel.fromEntity(chapaIntializer).toJson(),
        privateKey: AuthorizationModel.fromEntity(authorizationEntity).toJson(),
      );

      // Extract the checkout URL from the response and return it along with no exception.
      return (response['data']['checkout_url'].toString(), null);
    } on ChapaException catch (e) {
      // Return null and the encountered exception if an exception occurs.
      return (null, e);
    }
  }

  @override
  Future<(JsonType?, ChapaException?)> verify(
      String txRef, AuthorizationEntity authorizationEntity) async {
    try {
      // Call the getRequestVerify method of the remote data source to verify the Chapa payment.
      final response = await _remoteDataSource.getRequestVerify(
        txRef: txRef,
        privateKey: AuthorizationModel.fromEntity(authorizationEntity).toJson(),
      );

      // Return the response along with no exception.
      return (response, null);
    } on ChapaException catch (e) {
      // Return null and the encountered exception if an exception occurs.
      return (null, e);
    }
  }
}
