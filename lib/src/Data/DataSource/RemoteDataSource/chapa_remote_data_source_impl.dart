import '../../../../chapa_unofficial.dart';
// import '../../../Core/Exceptions/InitializationException/initialization_exception.dart';
import '../../../Core/apis.dart';
import '../../../Core/type_definitions.dart';
import 'chapa_remote_data_source.dart';
import 'package:dio/dio.dart' as client;

/// The implementation of the remote data source for Chapa interactions.
class ChapaRemoteDataSourceImpl extends ChapaRemoteDataSource {
  final client.Dio _dio;

  /// Constructs a `ChapaRemoteDataSourceImpl` object with the provided `Dio` instance.
  ChapaRemoteDataSourceImpl(this._dio);

  @override
  Future<JsonType> getRequestVerify({
    required String txRef,
    required JsonType privateKey,
  }) async {
    try {
      client.Response response = await _dio.get(
        Apis.chapaVerifyUrl + txRef,
        options: client.Options(headers: privateKey),
      );
      return response.data;
    } on client.DioException catch (e) {
      _handleException(e, () {
        throw VerificationException(msg: e.response?.data['message']);
      });

      throw UnknownChapaException();
    }
  }

  @override
  Future<JsonType> postRequestInitialize({
    required JsonType data,
    required JsonType privateKey,
  }) async {
    try {
      client.Response response = await _dio.post(
        Apis.chapaIntializeUrl,
        data: data,
        options: client.Options(headers: privateKey),
      );

      return response.data;
    } on client.DioException catch (e) {
      _handleException(e, () {
        throw InitializationException(msg: e.response?.data['message']);
      });

      throw UnknownChapaException();
    }
  }

  /// Handles the `DioException` and throws the corresponding exceptions.
  void _handleException(client.DioException e, Function wild) {
    if (e.response == null ||
        e.type == client.DioExceptionType.connectionTimeout) {
      // handle if there is network issue
      throw const NetworkException();
    }

    switch (e.response?.statusCode) {
      case 401:
        throw AuthException(msg: e.response?.data['message']);

      case 404:
      case 400:
        wild();

      case 500:
        throw ServerException(msg: e.response?.data['message']);
    }
  }
}
